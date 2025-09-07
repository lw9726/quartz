#!/usr/bin/env python3
"""
修复文件链接脚本
自动更新所有文件中的内部链接，使其与优化后的文件名匹配
"""

import os
import re
import glob
from pathlib import Path

def get_current_file_mapping():
    """获取当前文件的编号映射"""
    file_map = {}
    
    # 查找所有编号文件
    for file_path in glob.glob("content/**/*-*.md", recursive=True):
        basename = os.path.basename(file_path)
        
        # 提取编号和文件描述
        match = re.match(r'^(\d+)-(.+)\.md$', basename)
        if match:
            number, description = match.groups()
            
            # 记录当前编号格式
            file_map[f"{int(number):03d}-{description}.md"] = basename  # 3位数格式 → 当前格式
            file_map[f"{int(number):02d}-{description}.md"] = basename  # 2位数格式 → 当前格式
            file_map[f"{int(number)}-{description}.md"] = basename      # 1位数格式 → 当前格式
    
    return file_map

def update_links_in_file(file_path, file_map):
    """更新单个文件中的所有链接"""
    print(f"🔍 检查文件: {file_path}")
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        updated_count = 0
        
        # 查找所有[[xxx]]格式的链接
        def replace_link(match):
            nonlocal updated_count
            full_link = match.group(1)
            
            # 检查是否是编号文件链接
            if re.match(r'^\d+-', full_link):
                if full_link in file_map:
                    updated_count += 1
                    new_link = file_map[full_link].replace('.md', '')
                    print(f"    ✅ {full_link} → {new_link}")
                    return f"[[{new_link}]]"
                else:
                    # 尝试不同的编号格式
                    match_num = re.match(r'^(\d+)-(.+)$', full_link)
                    if match_num:
                        number, description = match_num.groups()
                        
                        # 尝试不同位数的编号格式
                        for fmt in [f"{int(number):03d}", f"{int(number):02d}", f"{int(number)}"]:
                            candidate = f"{fmt}-{description}.md"
                            if candidate in file_map:
                                updated_count += 1
                                new_link = file_map[candidate].replace('.md', '')
                                print(f"    ✅ {full_link} → {new_link}")
                                return f"[[{new_link}]]"
            
            return match.group(0)  # 未找到匹配，保持原样
        
        # 替换所有链接
        content = re.sub(r'\[\[([^\]]+)\]\]', replace_link, content)
        
        # 如果有更新，写回文件
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"  📝 已更新 {updated_count} 个链接")
            return updated_count
        else:
            print(f"  ✅ 无需更新")
            return 0
            
    except Exception as e:
        print(f"  ❌ 处理文件失败: {e}")
        return 0

def main():
    """主函数"""
    print("🔗 文件链接修复工具")
    print("=" * 50)
    
    # 获取当前文件映射
    print("📋 构建文件映射...")
    file_map = get_current_file_mapping()
    print(f"   发现 {len(file_map)} 个映射关系")
    
    # 查找所有需要检查的文件
    files_to_check = []
    for pattern in ["content/**/*.md", "*.md"]:
        files_to_check.extend(glob.glob(pattern, recursive=True))
    
    files_to_check = list(set(files_to_check))  # 去重
    print(f"📁 发现 {len(files_to_check)} 个文件需要检查")
    
    print("\n" + "=" * 50)
    
    # 修复每个文件
    total_updates = 0
    updated_files = 0
    
    for file_path in files_to_check:
        updates = update_links_in_file(file_path, file_map)
        if updates > 0:
            total_updates += updates
            updated_files += 1
    
    print("\n" + "=" * 50)
    print(f"🎯 修复完成!")
    print(f"📊 统计信息:")
    print(f"   - 检查文件: {len(files_to_check)} 个")
    print(f"   - 更新文件: {updated_files} 个")
    print(f"   - 修复链接: {total_updates} 个")

if __name__ == "__main__":
    main()
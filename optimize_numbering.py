#!/usr/bin/env python3
"""
智能文件编号优化脚本
根据每个目录的文件数量，自动选择最优的数字编码格式:
- ≤9 files: 1-digit (1, 2, 3...)
- 10-99 files: 2-digit (01, 02, 03...)
- 100-999 files: 3-digit (001, 002, 003...)
"""

import os
import re
import glob
import subprocess
from pathlib import Path

def get_numbered_files(directory):
    """获取目录中所有编号文件"""
    pattern = os.path.join(directory, "[0-9]*-*")
    files = glob.glob(pattern)
    return sorted(files)

def extract_number(filename):
    """提取文件名中的数字编号"""
    basename = os.path.basename(filename)
    match = re.match(r'^(\d+)-', basename)
    return int(match.group(1)) if match else None

def determine_optimal_format(file_count):
    """根据文件数量确定最优数字格式"""
    if file_count <= 9:
        return 1  # 1-digit
    elif file_count <= 99:
        return 2  # 2-digit
    else:
        return 3  # 3-digit

def format_number(number, digits):
    """格式化数字为指定位数"""
    return str(number).zfill(digits)

def get_current_format(files):
    """获取当前使用的数字格式位数"""
    if not files:
        return 3
    
    first_file = os.path.basename(files[0])
    match = re.match(r'^(\d+)-', first_file)
    if match:
        return len(match.group(1))
    return 3

def optimize_directory(directory):
    """优化单个目录的文件编号"""
    print(f"\n🔍 分析目录: {directory}")
    
    files = get_numbered_files(directory)
    if not files:
        print("  ❌ 没有找到编号文件")
        return False
    
    file_count = len(files)
    current_digits = get_current_format(files)
    optimal_digits = determine_optimal_format(file_count)
    
    print(f"  📊 文件数量: {file_count}")
    print(f"  📏 当前格式: {current_digits}位数")
    print(f"  🎯 最优格式: {optimal_digits}位数")
    
    if current_digits == optimal_digits:
        print(f"  ✅ 已经是最优格式，无需修改")
        return False
    
    print(f"  🔄 开始优化：{current_digits}位数 → {optimal_digits}位数")
    
    # 创建重命名列表
    rename_operations = []
    
    for file_path in files:
        directory_path = os.path.dirname(file_path)
        old_basename = os.path.basename(file_path)
        
        # 提取当前编号
        current_number = extract_number(file_path)
        if current_number is None:
            continue
        
        # 生成新的文件名
        new_number_str = format_number(current_number, optimal_digits)
        new_basename = re.sub(r'^\d+-', f'{new_number_str}-', old_basename)
        new_file_path = os.path.join(directory_path, new_basename)
        
        if old_basename != new_basename:
            rename_operations.append((file_path, new_file_path, old_basename, new_basename))
    
    # 执行重命名操作
    success_count = 0
    for old_path, new_path, old_name, new_name in rename_operations:
        try:
            os.rename(old_path, new_path)
            print(f"    ✅ {old_name} → {new_name}")
            success_count += 1
        except Exception as e:
            print(f"    ❌ 重命名失败 {old_name}: {e}")
    
    print(f"  🎉 完成! 成功重命名 {success_count}/{len(rename_operations)} 个文件")
    return success_count > 0

def main():
    """主函数"""
    print("🚀 文件编号智能优化工具")
    print("=" * 50)
    
    # 查找所有包含编号文件的目录
    content_dir = "content"
    if not os.path.exists(content_dir):
        print(f"❌ 内容目录不存在: {content_dir}")
        return
    
    # 使用find命令获取所有包含编号文件的目录
    try:
        result = subprocess.run(
            ['find', content_dir, '-name', '[0-9]*-*'],
            capture_output=True, text=True, check=True
        )
        
        # 提取目录列表
        directories = set()
        for line in result.stdout.strip().split('\n'):
            if line:
                directories.add(os.path.dirname(line))
        
        directories = sorted(directories)
        
    except subprocess.CalledProcessError as e:
        print(f"❌ 查找文件失败: {e}")
        return
    
    if not directories:
        print("❌ 没有找到包含编号文件的目录")
        return
    
    print(f"📁 发现 {len(directories)} 个目录包含编号文件:")
    for directory in directories:
        file_count = len(get_numbered_files(directory))
        current_digits = get_current_format(get_numbered_files(directory))
        optimal_digits = determine_optimal_format(file_count)
        status = "✅" if current_digits == optimal_digits else "🔄"
        print(f"  {status} {directory} ({file_count} files, {current_digits}→{optimal_digits} digits)")
    
    print("\n" + "=" * 50)
    
    # 执行优化
    optimized_count = 0
    for directory in directories:
        if optimize_directory(directory):
            optimized_count += 1
    
    print("\n" + "=" * 50)
    print(f"🎯 优化完成! 共优化了 {optimized_count} 个目录")
    
    if optimized_count > 0:
        print("\n💡 提示: 记得检查文件链接是否需要更新!")

if __name__ == "__main__":
    main()
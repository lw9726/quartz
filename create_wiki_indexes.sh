#!/bin/bash

# 为wiki目录下的每个子目录自动创建index.md文件

WIKI_DIR="content/wiki"

# 函数：生成文件夹的显示名称
get_folder_display_name() {
    local folder="$1"
    case "$folder" in
        "ALL_in_AI_Vibe_Coding")
            echo "ALL in AI Vibe Coding"
            ;;
        "HuggingFace_Spaces_free_server")
            echo "HuggingFace Spaces 免费服务器"
            ;;
        "english_learning")
            echo "English Learning"
            ;;
        "用神器Claude_Code打造贴身AI秘书团小白教程")
            echo "Claude Code AI秘书团教程"
            ;;
        *)
            echo "$folder"
            ;;
    esac
}

# 函数：分析文件类型
categorize_file() {
    local filename="$1"
    if [[ $filename =~ ^[0-9]+-核心概念- ]]; then
        echo "核心概念"
    elif [[ $filename =~ ^[0-9]+-核心实体- ]]; then
        echo "核心实体"
    elif [[ $filename =~ ^[0-9]+-核心流程- ]]; then
        echo "核心流程"
    elif [[ $filename =~ ^[0-9]+-核心洞察- ]]; then
        echo "核心洞察"
    elif [[ $filename =~ ^[0-9]+-核心事件- ]]; then
        echo "核心事件"
    elif [[ $filename =~ ^[0-9]+-主要内容- ]]; then
        echo "主要内容"
    elif [[ $filename =~ ^[0-9]+-宏观蓝图- ]]; then
        echo "宏观蓝图"
    elif [[ $filename =~ -宏观蓝图 ]]; then
        echo "宏观蓝图"
    else
        echo "其他内容"
    fi
}

# 函数：生成index.md内容
generate_index_content() {
    local folder="$1"
    local display_name="$2"
    local temp_file="/tmp/index_content.md"
    
    # 创建临时文件存储分类内容
    declare -A categories
    
    # 扫描文件并分类
    for file in "$WIKI_DIR/$folder"/*.md; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            # 跳过已存在的index.md
            if [[ "$filename" == "index.md" ]]; then
                continue
            fi
            
            category=$(categorize_file "$filename")
            if [[ -z "${categories[$category]}" ]]; then
                categories[$category]=""
            fi
            # 移除.md扩展名并添加链接
            link_name="${filename%.md}"
            categories[$category]+="- [[$link_name]]"$'\n'
        fi
    done
    
    # 生成完整内容
    cat > "$temp_file" <<EOF
---
title: $display_name
---

EOF
    
    # 按优先级顺序输出分类
    local ordered_categories=("核心概念" "核心洞察" "核心实体" "核心流程" "核心事件" "主要内容" "宏观蓝图" "其他内容")
    
    for category in "${ordered_categories[@]}"; do
        if [[ -n "${categories[$category]}" ]]; then
            echo "## $category" >> "$temp_file"
            echo "${categories[$category]}" >> "$temp_file"
        fi
    done
    
    cat "$temp_file"
    rm -f "$temp_file"
}

# 主逻辑
echo "🚀 开始为wiki目录创建index.md文件..."

for folder in "$WIKI_DIR"/*; do
    if [[ -d "$folder" ]]; then
        folder_name=$(basename "$folder")
        index_file="$folder/index.md"
        
        # 跳过已有index.md的目录
        if [[ -f "$index_file" ]]; then
            echo "⏭️  跳过 $folder_name (已存在index.md)"
            continue
        fi
        
        display_name=$(get_folder_display_name "$folder_name")
        echo "📝 为 $folder_name 创建index.md (显示名: $display_name)"
        
        # 生成并写入内容
        generate_index_content "$folder_name" "$display_name" > "$index_file"
        
        echo "✅ 完成: $index_file"
    fi
done

echo ""
echo "🎉 所有index.md文件创建完成！"
echo ""
echo "📋 创建的文件列表:"
find "$WIKI_DIR" -name "index.md" -newer . 2>/dev/null | sort
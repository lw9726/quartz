#!/bin/bash

# 通用的文件夹index.md生成脚本
# 使用方法: ./create_folder_indexes.sh [目录路径] [可选：自定义显示名称]

# 默认参数
TARGET_DIR="${1:-content}"
CUSTOM_TITLE="$2"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 帮助信息
show_help() {
    echo "📖 通用文件夹index.md生成脚本"
    echo ""
    echo "🔧 使用方法:"
    echo "  $0 [目录路径] [可选：自定义显示名称]"
    echo ""
    echo "📌 示例:"
    echo "  $0                                    # 为content目录下所有子目录生成index"
    echo "  $0 content/books                      # 为content/books下所有子目录生成index"
    echo "  $0 content/poem '古典诗歌集合'        # 为content/poem生成自定义标题的index"
    echo ""
    echo "✨ 功能:"
    echo "  - 自动识别文件类型并分类"
    echo "  - 生成结构化的宏观蓝图内容" 
    echo "  - 跳过已存在的index.md文件"
    echo "  - 智能生成友好的显示名称"
}

# 函数：生成友好的显示名称
get_display_name() {
    local folder_path="$1"
    local folder_name=$(basename "$folder_path")
    
    # 如果提供了自定义标题，直接使用
    if [[ -n "$CUSTOM_TITLE" ]]; then
        echo "$CUSTOM_TITLE"
        return
    fi
    
    # 根据文件夹名称生成友好名称
    case "$folder_name" in
        "三体")
            echo "三体三部曲"
            ;;
        "booka")
            echo "Graph Data Science with Neo4j"
            ;;
        "poem")
            echo "古典诗歌"
            ;;
        "books")
            echo "书籍资料"
            ;;
        "wiki")
            echo "知识库"
            ;;
        "唐诗")
            echo "唐代诗歌"
            ;;
        "宋词")  
            echo "宋代词作"
            ;;
        "诗人")
            echo "诗人介绍"
            ;;
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
            # 默认处理：首字母大写，下划线转空格
            echo "$folder_name" | sed 's/_/ /g' | sed 's/\b\w/\u&/g'
            ;;
    esac
}

# 函数：分析文件类型
categorize_file() {
    local filename="$1"
    local folder_name="$2"
    
    # 基于文件名前缀的分类
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
    elif [[ $filename =~ ^[0-9]+-宏观蓝图- ]] || [[ $filename =~ -宏观蓝图 ]]; then
        echo "宏观蓝图"
    elif [[ $filename =~ ^[0-9]+-人物- ]]; then
        echo "人物介绍"
    elif [[ $filename =~ ^[0-9]+-组织- ]]; then
        echo "组织机构"
    elif [[ $filename =~ ^[0-9]+-事件- ]]; then
        echo "重要事件"
    elif [[ $filename =~ ^[0-9]+-概念- ]]; then
        echo "核心概念"
    elif [[ $filename =~ ^[0-9]+-时空- ]]; then
        echo "时空设定"
    elif [[ $filename =~ ^[0-9]+-诗- ]]; then
        echo "诗歌作品"
    elif [[ $filename =~ ^[0-9]+-词- ]]; then
        echo "词作"
    elif [[ $filename =~ ^[0-9]+-诗人- ]]; then
        echo "诗人介绍"
    elif [[ $filename =~ ^[0-9]+-主题- ]]; then
        echo "主题思想"
    else
        # 根据文件夹类型推断
        case "$folder_name" in
            "三体"|"books")
                echo "相关内容"
                ;;
            "poem"|"唐诗"|"宋词")
                echo "文学作品"
                ;;
            *)
                echo "其他内容"
                ;;
        esac
    fi
}

# 函数：生成index.md内容
generate_index_content() {
    local folder="$1"
    local display_name="$2"
    local temp_file="/tmp/index_content_$(basename "$folder").md"
    
    # 创建关联数组存储分类内容
    declare -A categories
    
    # 扫描文件并分类
    for file in "$folder"/*.md; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            # 跳过已存在的index.md
            if [[ "$filename" == "index.md" ]]; then
                continue
            fi
            
            folder_name=$(basename "$folder")
            category=$(categorize_file "$filename" "$folder_name")
            
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
    
    # 定义分类显示顺序
    local ordered_categories=("宏观蓝图" "核心概念" "核心洞察" "核心实体" "核心流程" "核心事件" "人物介绍" "组织机构" "重要事件" "时空设定" "诗歌作品" "词作" "诗人介绍" "主题思想" "文学作品" "主要内容" "相关内容" "其他内容")
    
    # 按顺序输出非空分类
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
main() {
    # 检查帮助参数
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    
    # 验证目录存在
    if [[ ! -d "$TARGET_DIR" ]]; then
        echo -e "${RED}❌ 错误: 目录 '$TARGET_DIR' 不存在${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}🚀 开始为目录生成index.md文件...${NC}"
    echo -e "${YELLOW}📂 目标目录: $TARGET_DIR${NC}"
    echo ""
    
    local created_count=0
    local skipped_count=0
    
    # 如果指定的是单个文件夹且有自定义标题，直接处理该文件夹
    if [[ -n "$CUSTOM_TITLE" ]] && [[ -d "$TARGET_DIR" ]]; then
        local index_file="$TARGET_DIR/index.md"
        if [[ -f "$index_file" ]]; then
            echo -e "${YELLOW}⏭️  跳过 $(basename "$TARGET_DIR") (已存在index.md)${NC}"
            ((skipped_count++))
        else
            echo -e "${GREEN}📝 为 $(basename "$TARGET_DIR") 创建index.md (自定义标题: $CUSTOM_TITLE)${NC}"
            generate_index_content "$TARGET_DIR" "$CUSTOM_TITLE" > "$index_file"
            echo -e "${GREEN}✅ 完成: $index_file${NC}"
            ((created_count++))
        fi
    else
        # 处理目录下的所有子目录
        for folder in "$TARGET_DIR"/*; do
            if [[ -d "$folder" ]]; then
                folder_name=$(basename "$folder")
                index_file="$folder/index.md"
                
                # 跳过已有index.md的目录
                if [[ -f "$index_file" ]]; then
                    echo -e "${YELLOW}⏭️  跳过 $folder_name (已存在index.md)${NC}"
                    ((skipped_count++))
                    continue
                fi
                
                display_name=$(get_display_name "$folder")
                echo -e "${GREEN}📝 为 $folder_name 创建index.md (显示名: $display_name)${NC}"
                
                # 生成并写入内容
                generate_index_content "$folder" "$display_name" > "$index_file"
                
                echo -e "${GREEN}✅ 完成: $index_file${NC}"
                ((created_count++))
            fi
        done
    fi
    
    echo ""
    echo -e "${BLUE}🎉 处理完成！${NC}"
    echo -e "${GREEN}📊 统计: 创建 $created_count 个，跳过 $skipped_count 个${NC}"
    
    if [[ $created_count -gt 0 ]]; then
        echo ""
        echo -e "${BLUE}📋 新创建的index.md文件:${NC}"
        find "$TARGET_DIR" -name "index.md" -newer . 2>/dev/null | sort
    fi
}

# 运行主函数
main "$@"
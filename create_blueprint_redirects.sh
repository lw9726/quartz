#!/bin/bash

# 通用的宏观蓝图跳转index.md生成脚本
# 自动检测每个文件夹的宏观蓝图文件，并创建跳转的index.md

TARGET_DIR="${1:-content}"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 帮助信息
show_help() {
    echo "📖 宏观蓝图跳转页面生成脚本"
    echo ""
    echo "🔧 使用方法:"
    echo "  $0 [目录路径]"
    echo ""
    echo "📌 示例:"
    echo "  $0                    # 为content目录下所有子目录生成跳转"
    echo "  $0 content/wiki       # 为wiki下所有子目录生成跳转"
    echo "  $0 content/books      # 为books下所有子目录生成跳转"
    echo ""
    echo "✨ 功能:"
    echo "  - 自动检测文件夹中的宏观蓝图文件"
    echo "  - 生成自动跳转到宏观蓝图的index.md"
    echo "  - 支持多种宏观蓝图文件命名格式"
}

# 函数：查找文件夹中的宏观蓝图文件
find_blueprint_file() {
    local folder="$1"
    local folder_name=$(basename "$folder")
    
    # 可能的蓝图文件命名格式
    local patterns=(
        "${folder_name}-宏观蓝图.md"
        "*-宏观蓝图-*.md"
        "*宏观蓝图*.md"
        "000-宏观蓝图*.md"
        "*蓝图.md"
    )
    
    for pattern in "${patterns[@]}"; do
        # 使用find并正确处理特殊字符
        while IFS= read -r -d '' file; do
            if [[ -f "$file" ]]; then
                basename "$file"
                return 0
            fi
        done < <(find "$folder" -maxdepth 1 -name "$pattern" -type f -print0 2>/dev/null)
    done
    
    return 1
}

# 函数：获取文件夹的显示名称
get_display_name() {
    local folder_path="$1"
    local folder_name=$(basename "$folder_path")
    
    case "$folder_name" in
        "三体")
            echo "三体三部曲"
            ;;
        "booka")
            echo "Graph Data Science with Neo4j"
            ;;
        "neo4j")
            echo "Neo4j知识图谱"
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
            echo "$folder_name" | sed 's/_/ /g' | sed 's/\b\w/\u&/g'
            ;;
    esac
}

# 函数：生成跳转页面内容
generate_redirect_content() {
    local display_name="$1"
    local blueprint_file="$2"
    local blueprint_name="${blueprint_file%.md}"
    
    cat <<EOF
---
title: $display_name
---

<script>
// 自动跳转到宏观蓝图页面
window.location.href = "./$blueprint_name";
</script>

**正在跳转到${display_name}宏观蓝图...**

如果没有自动跳转，请点击：[$display_name - 宏观蓝图](./$blueprint_name)
EOF
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
    
    echo -e "${BLUE}🚀 开始生成宏观蓝图跳转页面...${NC}"
    echo -e "${YELLOW}📂 目标目录: $TARGET_DIR${NC}"
    echo ""
    
    local created_count=0
    local skipped_count=0
    local no_blueprint_count=0
    
    # 处理目录下的所有子目录
    for folder in "$TARGET_DIR"/*; do
        if [[ -d "$folder" ]]; then
            folder_name=$(basename "$folder")
            index_file="$folder/index.md"
            display_name=$(get_display_name "$folder")
            
            # 查找宏观蓝图文件
            blueprint_file=$(find_blueprint_file "$folder")
            
            if [[ -z "$blueprint_file" ]]; then
                echo -e "${YELLOW}⚠️  跳过 $folder_name (未找到宏观蓝图文件)${NC}"
                ((no_blueprint_count++))
                continue
            fi
            
            # 检查是否已存在index.md
            if [[ -f "$index_file" ]]; then
                echo -e "${YELLOW}🔄 替换 $folder_name 的index.md${NC}"
            else
                echo -e "${GREEN}📝 创建 $folder_name 的跳转页面${NC}"
            fi
            
            echo -e "${BLUE}   📍 蓝图文件: $blueprint_file${NC}"
            echo -e "${BLUE}   📄 显示名称: $display_name${NC}"
            
            # 生成跳转页面内容
            generate_redirect_content "$display_name" "$blueprint_file" > "$index_file"
            
            echo -e "${GREEN}✅ 完成: $index_file${NC}"
            ((created_count++))
        fi
    done
    
    echo ""
    echo -e "${BLUE}🎉 处理完成！${NC}"
    echo -e "${GREEN}📊 统计:${NC}"
    echo -e "${GREEN}   - 创建/更新: $created_count 个${NC}"
    echo -e "${YELLOW}   - 无蓝图文件: $no_blueprint_count 个${NC}"
    
    if [[ $created_count -gt 0 ]]; then
        echo ""
        echo -e "${BLUE}📋 处理的文件夹:${NC}"
        for folder in "$TARGET_DIR"/*; do
            if [[ -d "$folder" ]] && [[ -f "$folder/index.md" ]]; then
                echo -e "${GREEN}   ✓ $(basename "$folder")${NC}"
            fi
        done
    fi
}

# 运行主函数
main "$@"
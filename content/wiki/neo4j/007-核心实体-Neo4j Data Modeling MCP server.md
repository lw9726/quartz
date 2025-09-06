---
tags:
  - neo4j
  - 核心实体
---
Neo4j Data Modeling MCP server 是一个实现了模型上下文协议（MCP）的服务器，专门用于辅助 Neo4j 的图数据建模。
> This blog details how you can use the Neo4j Data Modeling MCP server to generate graph data models for your Neo4j-backed applications.

## 展开阐述
Neo4j Data Modeling MCP server 是一个关键的工具，它充当了AI代理（如 [[009-核心实体-Claude Desktop]]）与 [[002-核心概念-Graph Data Modeling]] 流程之间的桥梁。该服务器通过 [[001-核心概念-Model Context Protocol (MCP)|MCP]] 提供了一系列标准化的资源和工具，极大地简化了为 [[003-核心概念-Neo4j]] 后端应用创建和迭代数据模型的过程。

该服务器（当前版本 v0.1.1）提供的核心功能包括：
1.  **资源定义**: 提供用于定义图数据模型（节点、关系、属性）的结构化资源。
2.  **验证工具**: 验证数据模型的正确性，例如检查节点上的键属性、重复项以及关系源和目标的存在性。
3.  **可视化工具**: 生成 [[005-核心概念-Mermaid]] 图的配置，以便快速可视化数据模型。
4.  **导入/导出工具**: 支持从 [[006-核心概念-Arrows.app]] 等工具导入手动创建的模型，或将AI生成的模型导出到 Arrows.app 进行手动编辑。
5.  **代码生成工具**: 生成用于数据导入的 [[004-核心概念-Cypher]] 代码，包括索引和约束。

在[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]中，该服务器与 [[008-核心实体-Neo4j Cypher MCP server]] 结合使用，实现了从数据建模到数据查询的完整闭环。

## 关联节点
- [[001-核心概念-Model Context Protocol (MCP)]]
- [[002-核心概念-Graph Data Modeling]]
- [[008-核心实体-Neo4j Cypher MCP server]]
- [[012-核心流程-End-To-End Developer Flow]]
- [[005-核心概念-Mermaid]]
- [[006-核心概念-Arrows.app]]
- [[004-核心概念-Cypher]]

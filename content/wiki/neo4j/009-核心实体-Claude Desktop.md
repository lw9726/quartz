---
tags:
  - neo4j
  - 核心实体
---
Claude Desktop 是一个与模型上下文协议（MCP）兼容的客户端应用程序。
> There are many MCP-compatible clients, such as Claude Desktop and the Cursor IDE.

## 展开阐述
Claude Desktop 是一个桌面应用程序，它充当了用户与 AI 代理进行交互的前端界面。作为一个与 [[001-核心概念-Model Context Protocol (MCP)|MCP]] 兼容的客户端，它能够集成和利用各种 MCP 服务器提供的功能。

在本文描述的[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]中，Claude Desktop 被用作主要的开发环境。开发者通过在 Claude Desktop 中配置 [[007-核心实体-Neo4j Data Modeling MCP server]] 和 [[008-核心实体-Neo4j Cypher MCP server]]，可以直接在这个应用内完成以下任务：
-   向 AI 代理提供数据源（如 [[011-核心实体-Survivor Borneo Wiki]] 的链接）和业务需求。
-   调用 MCP 服务器的工具来生成、验证和修改[[002-核心概念-Graph Data Modeling|图数据模型]]。
-   利用其对 [[005-核心概念-Mermaid]] 的支持，可视化生成的数据模型。
-   执行 [[004-核心概念-Cypher]] 查询，与 [[003-核心概念-Neo4j]] 数据库交互并获取结果。

Claude Desktop 与 [[010-核心实体-Cursor IDE]] 一样，是展示 MCP 如何将强大的后端工具集成到用户友好的客户端应用中的一个典型例子。

## 关联节点
- [[001-核心概念-Model Context Protocol (MCP)]]
- [[007-核心实体-Neo4j Data Modeling MCP server]]
- [[008-核心实体-Neo4j Cypher MCP server]]
- [[010-核心实体-Cursor IDE]]
- [[012-核心流程-End-To-End Developer Flow]]

---
tags:
  - neo4j
  - 核心流程
---
端到端开发流程描述了使用 MCP 服务器进行图应用开发的通用过程。
> There’s a common process when an agent is using the Data Modeling MCP server for development. This process includes some data discovery within the client application and, optionally, the Neo4j Cypher MCP server for loading and querying the resulting graph.

## 展开阐述
端到端开发流程（End-To-End Developer Flow）是本文的核心，它展示了如何利用一系列 [[001-核心概念-Model Context Protocol (MCP)|MCP]] 工具，在像 [[009-核心实体-Claude Desktop]] 这样的客户端应用中，完成一个从数据探索到图数据库查询的完整开发周期。

这个流程大致可以分为以下几个阶段：
1.  **数据提供与需求分析**: 开发者向 AI 代理提供数据源（如 [[011-核心实体-Survivor Borneo Wiki]]）和业务用例。
2.  **数据建模与验证**: AI 代理使用 [[007-核心实体-Neo4j Data Modeling MCP server]] 的资源来构建[[002-核心概念-Graph Data Modeling|图数据模型]]的 JSON 表示，并通过验证工具检查模型的正确性。
3.  **模型可视化与迭代**: 使用 [[005-核心概念-Mermaid]] 工具生成数据模型的可视化图表，开发者可以基于图表提出修改意见，AI 代理会重复第 2 和第 3 步，直到模型令人满意。
4.  **代码生成与数据导入**: [[007-核心实体-Neo4j Data Modeling MCP server]] 生成 [[004-核心概念-Cypher]] 代码，用于在 [[003-核心概念-Neo4j]] 数据库中创建约束、索引并导入数据。
5.  **数据查询与验证**: 使用 [[008-核心实体-Neo4j Cypher MCP server]] 执行 [[004-核心概念-Cypher]] 查询，以验证数据是否正确加载，并从图中获取业务问题的答案。

这个流程的优势在于，它将数据建模、验证、可视化、导入和查询等多个步骤集成在同一个应用程序中，实现了高效、快速的概念验证和迭代开发。

## 关联节点
- [[001-核心概念-Model Context Protocol (MCP)]]
- [[007-核心实体-Neo4j Data Modeling MCP server]]
- [[008-核心实体-Neo4j Cypher MCP server]]
- [[009-核心实体-Claude Desktop]]
- [[013-核心流程-Data Modeling Process]]
- [[014-核心流程-Data Ingestion Process]]
- [[011-核心实体-Survivor Borneo Wiki]]

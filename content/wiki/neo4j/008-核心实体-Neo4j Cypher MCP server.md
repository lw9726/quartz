tags:
  - neo4j
  - 核心实体
Neo4j Cypher MCP server 是一个实现了模型上下文协议（MCP）的服务器，它允许AI代理执行 Cypher 查询。
> ...optionally, the Neo4j Cypher MCP server for loading and querying the resulting graph.

## 展开阐述
Neo4j Cypher MCP server 是 [[012-核心流程-End-To-End Developer Flow|端到端开发流程]] 中的一个重要组成部分，它赋予了 AI 代理（如 [[009-核心实体-Claude Desktop]]）直接与 [[003-核心概念-Neo4j]] 数据库交互的能力。

该服务器通过 [[001-核心概念-Model Context Protocol (MCP)|MCP]] 暴露了执行 [[004-核心概念-Cypher]] 查询的功能。这在开发流程的多个阶段都非常有用：
1.  **数据导入**: AI 代理可以利用此服务器来执行由 [[007-核心实体-Neo4j Data Modeling MCP server]] 生成的 Cypher 导入脚本，从而完成 [[014-核心流程-Data Ingestion Process|数据导入过程]]。
2.  **数据验证**: 在数据导入后，可以立即运行 Cypher 查询来验证数据是否已按预期正确加载。
3.  **数据查询**: 开发者可以直接在客户端应用中，通过自然语言向 AI 代理提问，AI 代理会将问题转化为 Cypher 查询，并通过该服务器执行，最终返回问题的答案。

在配置上，Neo4j Cypher MCP server 需要设置环境变量，如 `NEO4J_URL`、`NEO4J_USERNAME`、`NEO4J_PASSWORD` 和 `NEO4J_DATABASE`，以连接到指定的 Neo4j 实例。

## 关联节点
- [[001-核心概念-Model Context Protocol (MCP)]]
- [[004-核心概念-Cypher]]
- [[003-核心概念-Neo4j]]
- [[007-核心实体-Neo4j Data Modeling MCP server]]
- [[012-核心流程-End-To-End Developer Flow]]
- [[014-核心流程-Data Ingestion Process]]
- [[009-核心实体-Claude Desktop]]

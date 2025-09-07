---
tags:
  - neo4j
  - 核心概念
---
Cypher 是 Neo4j 的查询语言。
> The MCP server also provides tools that generate Cypher code to ingest data according to the data model. This code includes the necessary indexes and constraints, as well as the code for ingesting nodes, relationships, and properties.

## 展开阐述
Cypher 是用于查询和操作 [[03-核心概念-Neo4j]] 图数据库的声明式查询语言。在本文所描述的[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]中，Cypher 扮演着关键角色。

[[07-核心实体-Neo4j Data Modeling MCP server]] 提供了代码生成工具，可以自动生成用于数据导入的 Cypher 代码。这些生成的代码不仅包括创建节点和关系的指令，还包含了建立索引（indexes）和约束（constraints）的语句，这对于保证数据一致性和查询性能至关重要。

此外，[[08-核心实体-Neo4j Cypher MCP server]] 允许 AI 代理（如 [[09-核心实体-Claude Desktop]]）直接执行 Cypher 查询，从而实现对 [[03-核心概念-Neo4j]] 数据库的实时查询和数据验证。例如，在数据导入后，开发者可以立即运行 Cypher 查询来确认数据是否已按预期加载，并获取业务问题的答案。

尽管 AI 代理有时可能会选择自行编写 Cypher 代码，但利用 MCP 工具生成的代码可以确保与数据模型的一致性。

## 关联节点
- [[03-核心概念-Neo4j]]
- [[07-核心实体-Neo4j Data Modeling MCP server]]
- [[08-核心实体-Neo4j Cypher MCP server]]
- [[12-核心流程-End-To-End Developer Flow]]
- [[14-核心流程-Data Ingestion Process]]

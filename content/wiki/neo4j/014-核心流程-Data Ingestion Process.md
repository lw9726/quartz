---
tags:
  - neo4j
  - 核心流程
---
数据导入流程是将经过验证的数据模型和原始数据加载到 Neo4j 数据库中的过程。
> The MCP server also exposes a resource that lays out the process of ingesting data into Neo4j so you can use the Data Modeling MCP server in combination with other ingestion tools.

## 展开阐述
数据导入流程（Data Ingestion Process）是[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]的最后阶段，它负责将前期[[013-核心流程-Data Modeling Process|建模和验证]]的成果——即最终的[[002-核心概念-Graph Data Modeling|图数据模型]]——以及原始数据，实际加载到[[003-核心概念-Neo4j]]数据库中。

这个流程主要依赖于[[007-核心实体-Neo4j Data Modeling MCP server]]提供的代码生成工具。该工具能够生成一系列的[[004-核心概念-Cypher]]查询语句，这些语句通常包括：
1.  **创建约束和索引**: 在导入数据之前，首先为节点属性创建唯一性约束（constraints）和索引（indexes），以确保数据的完整性并优化查询性能。
2.  **导入节点和属性**: 逐一创建数据模型中定义的各种节点，并设置它们的属性。
3.  **导入关系和属性**: 在节点创建完毕后，创建连接它们的关系，并设置关系的属性。

AI 代理（如[[009-核心实体-Claude Desktop]]）可以调用[[008-核心实体-Neo4j Cypher MCP server]]来执行这些由工具生成的 Cypher 代码，从而完成整个数据导入过程。需要注意的是，尽管通过客户端（如 Claude Desktop）直接导入数据对于快速概念验证很方便，但文章建议在生产环境中不推荐这样做。

完成导入后，就可以通过查询来验证数据并开始探索图谱了。

## 关联节点
- [[012-核心流程-End-To-End Developer Flow]]
- [[007-核心实体-Neo4j Data Modeling MCP server]]
- [[008-核心实体-Neo4j Cypher MCP server]]
- [[004-核心概念-Cypher]]
- [[003-核心概念-Neo4j]]
- [[013-核心流程-Data Modeling Process]]

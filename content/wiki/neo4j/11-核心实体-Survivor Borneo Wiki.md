---
tags:
  - neo4j
  - 核心实体
---
Survivor Borneo Wiki 是一个包含了关于《幸存者：婆罗洲》这一季节目详细信息的网站，被用作本文示例中的数据来源。
> The data models below were generated from the Survivor Borneo Wiki.

## 展开阐述
Survivor Borneo Wiki 在本文的[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]示例中，充当了原始非结构化数据的来源。AI 代理（如 [[09-核心实体-Claude Desktop]]）通过分析这个 Wiki 页面的内容，来理解数据中的实体、关系和属性，进而开始[[013-核心流程-Data Modeling Process|数据建模过程]]。

这个例子展示了如何将一个公开的、基于文本的网页内容，通过 AI 代理和 [[07-核心实体-Neo4j Data Modeling MCP server]] 的能力，转化成一个结构化的[[002-核心概念-Graph Data Modeling|图数据模型]]。这个模型随后被加载到 [[03-核心概念-Neo4j]] 数据库中，并可以通过 [[04-核心概念-Cypher]] 进行查询，以回答关于“谁投票淘汰了谁”或“谁赢得了豁免”等具体的业务问题。

这个过程体现了从非结构化数据中提取价值，并将其构建为知识图谱的典型应用场景。

## 关联节点
- [[12-核心流程-End-To-End Developer Flow]]
- [[13-核心流程-Data Modeling Process]]
- [[09-核心实体-Claude Desktop]]
- [[02-核心概念-Graph Data Modeling]]
- [[03-核心概念-Neo4j]]

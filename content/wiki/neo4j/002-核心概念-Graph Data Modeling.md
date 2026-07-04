---
tags:
  - neo4j
  - 核心概念
---
图数据建模（Graph data modeling）是识别数据中的实体并用关系将它们连接起来的过程。
> Graph data modeling consists of identifying entities within your data and connecting them with relationships. Both entities and relationships may also have properties that provide additional information.

## 展开阐述
图数据建模是构建任何[[003-核心概念-Neo4j]]应用的基础步骤。这个过程的核心在于首先理解业务用例，因为它直接决定了我们需要编写的查询语句，并最终影响数据在图中的表示方式。

一个典型的图数据模型包含三种元素：
1.  **节点 (Entities)**：代表数据中的核心实体。
2.  **关系 (Relationships)**：连接不同节点，描述它们之间的关系。
3.  **属性 (Properties)**：为节点和关系提供额外的详细信息。

由于[[003-核心概念-Neo4j]]是一个无模式数据库（schemaless database），数据模型的重构变得相对容易。在项目的开发周期中，为了提升查询性能或增加新的用例，数据模型经常被多次重构。[[007-核心实体-Neo4j Data Modeling MCP server]]正是为了简化这一迭代过程而设计的工具，它提供了验证、可视化（如通过[[005-核心概念-Mermaid]]）和代码生成等功能。

整个数据建模的过程，即[[013-核心流程-Data Modeling Process]]，是[[012-核心流程-End-To-End Developer Flow]]中的一个关键环节。

## 关联节点
- [[003-核心概念-Neo4j]]
- [[007-核心实体-Neo4j Data Modeling MCP server]]
- [[013-核心流程-Data Modeling Process]]
- [[012-核心流程-End-To-End Developer Flow]]
- [[005-核心概念-Mermaid]]
- [[004-核心概念-Cypher]]

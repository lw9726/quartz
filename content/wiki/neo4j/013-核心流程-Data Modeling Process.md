tags:
  - neo4j
  - 核心流程
数据建模流程是指在AI代理的辅助下，创建、验证和迭代图数据模型的过程。
> Once the agent analyzes the data and understands your use cases, it can begin the modeling process.

## 展开阐述
数据建模流程（Data Modeling Process）是[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]中的一个核心环节。它起始于 AI 代理（如 [[009-核心实体-Claude Desktop]]）对原始数据（如 [[011-核心实体-Survivor Borneo Wiki]]）和业务用例的分析。

这个流程的具体步骤如下：
1.  **构建 JSON 表示**: AI 代理会参考 [[007-核心实体-Neo4j Data Modeling MCP server]] 提供的 schema 资源，将从数据中理解的实体、关系和属性构建成一个 JSON 格式的[[002-核心概念-Graph Data Modeling|数据模型]]。
2.  **模型验证**: 生成的 JSON 数据模型会被传递给数据模型验证工具。该工具会检查模型中可能存在的错误，例如缺少键、重复项等，并将错误返回给 AI 代理。
3.  **错误修正与信息补全**: AI 代理根据验证工具返回的错误来修正模型，并可能会提示用户提供任何缺失的信息。
4.  **可视化与迭代**: 一旦生成了有效的数据模型，AI 代理就可以使用 [[005-核心概念-Mermaid]] 配置工具来生成可视化图表。开发者可以审查这个图表，并请求进行修改，这个过程（修正 -> 验证 -> 可视化）会一直循环，直到模型达到满意的状态。

这个迭代式的流程确保了最终产出的数据模型是准确、有效且符合业务需求的。

## 关联节点
- [[012-核心流程-End-To-End Developer Flow]]
- [[002-核心概念-Graph Data Modeling]]
- [[007-核心实体-Neo4j Data Modeling MCP server]]
- [[009-核心实体-Claude Desktop]]
- [[005-核心概念-Mermaid]]
- [[011-核心实体-Survivor Borneo Wiki]]

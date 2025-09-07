---
tags:
  - neo4j
  - 核心概念
---
Arrows.app 是一个用于手动创建和绘制图数据模型的Web工具。
> Use the Arrows.app drawing tool to manually create data models that can then be imported and modified within the client application. AI-generated data models can also be exported to Arrows format via a tool call so you can edit manually within Arrows.

## 展开阐述
Arrows.app 是一个基于Web的绘图工具，专门用于创建和编辑[[002-核心概念-Graph Data Modeling|图数据模型]]。它在[[012-核心流程-End-To-End Developer Flow|端到端开发流程]]中扮演着连接AI生成与人工编辑之间桥梁的角色。

Arrows.app 提供了两种主要的工作方式：
1.  **手动创建**: 开发者可以使用 Arrows.app 从头开始手动绘制数据模型。这些模型随后可以被导入到客户端应用程序（如 [[09-核心实体-Claude Desktop]]）中，并由 [[07-核心实体-Neo4j Data Modeling MCP server]] 进行处理和修改。
2.  **导入和编辑**: 由AI代理生成的数据模型，可以通过工具调用导出为 Arrows 格式。这使得开发者可以在 Arrows.app 的可视化界面中对AI生成的模型进行手动的、精细的调整和优化。

在 Arrows.app 中，为了保持与客户端应用生成的信息兼容，属性（property）采用了特定的格式：`<property-name>: <neo4j-type> | <description> | OPTIONAL<key-identifier>`。其中 `KEY` 标识符在每个节点或关系中应是唯一的，这是当前数据建模MCP服务器的一个约束。

## 关联节点
- [[02-核心概念-Graph Data Modeling]]
- [[07-核心实体-Neo4j Data Modeling MCP server]]
- [[09-核心实体-Claude Desktop]]
- [[12-核心流程-End-To-End Developer Flow]]

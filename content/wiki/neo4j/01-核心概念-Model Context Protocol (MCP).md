---
tags:
  - neo4j
  - 核心概念
---
Model Context Protocol (MCP) 是一种为代理（agents）提供标准化工具访问的强大方式。
> MCP provides a powerful way for agents to easily gain access to standardized tooling. It’s a protocol that defines how applications can provide context in the form of tools, resources, and prompts to an LLM.

## 展开阐述
Model Context Protocol (MCP) 是一个协议，它定义了应用程序如何向大型语言模型（LLM）提供上下文，这些上下文以工具、资源和提示的形式存在。MCP 的设计目的是让AI代理能够轻松地接入和使用标准化的工具集，从而增强其在特定任务（如[[02-核心概念-Graph Data Modeling]]）中的能力。

在本文中，MCP通过两个具体的服务器实现来体现其价值：[[07-核心实体-Neo4j Data Modeling MCP server]] 和 [[08-核心实体-Neo4j Cypher MCP server]]。这些服务器使得像 [[09-核心实体-Claude Desktop]] 或 [[10-核心实体-Cursor IDE]] 这样的客户端应用，能够利用专门为 [[03-核心概念-Neo4j]] 设计的图数据建模和查询功能。

整个工作流程，即[[12-核心流程-End-To-End Developer Flow]]，展示了如何结合使用这些MCP服务器来完成一个从数据分析到图构建和查询的完整开发周期。

## 关联节点
- [[02-核心概念-Graph Data Modeling]]
- [[07-核心实体-Neo4j Data Modeling MCP server]]
- [[08-核心实体-Neo4j Cypher MCP server]]
- [[12-核心流程-End-To-End Developer Flow]]
- [[09-核心实体-Claude Desktop]]
- [[10-核心实体-Cursor IDE]]
- [[03-核心概念-Neo4j]]

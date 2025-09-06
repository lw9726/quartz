# Explore the Neo4j Data Modeling MCP Server

## Enhance your graph data modeling workflow

[](https://medium.com/@a-gilmore?source=post_page---byline--56a6fdb1d2f7---------------------------------------)[Alex Gilmore](https://medium.com/@a-gilmore?source=post_page---byline--56a6fdb1d2f7---------------------------------------)Follow8 min read·Jun 25, 2025[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fneo4j%2F56a6fdb1d2f7&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fneo4j%2Fexplore-the-neo4j-data-modeling-mcp-server-56a6fdb1d2f7&user=Alex+Gilmore&userId=aaa89f5d832&source=---header_actions--56a6fdb1d2f7---------------------clap_footer------------------)2

[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F56a6fdb1d2f7&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fneo4j%2Fexplore-the-neo4j-data-modeling-mcp-server-56a6fdb1d2f7&source=---header_actions--56a6fdb1d2f7---------------------bookmark_footer------------------)Listen

Share

![Image](https://miro.medium.com/v2/resize:fit:700/1*fBKcjArkrPIeQoz0bw5LHg.jpeg)

## Introduction

In this blog, I’ll discuss the benefits of the [Model Context Protocol (MCP)](https://neo4j.com/blog/developer/model-context-protocol/), what the Neo4j Data Modeling MCP server provides to your agentic applications, and how to implement it in an end-to-end workflow with other MCP servers.

MCP provides a powerful way for agents to easily gain access to standardized tooling. It’s a protocol that defines how applications can provide context in the form of tools, resources, and prompts to an LLM. This blog details how you can use the Neo4j Data Modeling MCP server to generate graph data models for your Neo4j-backed applications.

[## Introduction - Model Context Protocol

Get started with the Model Context Protocol (MCP)modelcontextprotocol.io

](https://modelcontextprotocol.io/introduction?source=post_page-----56a6fdb1d2f7---------------------------------------)Graph data modeling consists of identifying entities within your data and connecting them with relationships. Both entities and relationships may also have properties that provide additional information.

When creating graph data models, it’s important to first understand the use cases they will address. This informs the queries we’ll write and, ultimately, how our data should be represented in the graph.

Neo4j is a schemaless database, so refactoring the data model is easy to do. This is because it’s fairly common to refactor your data model to improve query performance or add additional use cases. Since the data modeling step may be revisited multiple times throughout a project’s development cycle, the Neo4j Data Modeling MCP server is a useful asset to have.

The current release of the Neo4j Data Modeling MCP Server is v0.1.1.

[## mcp-neo4j/servers/mcp-neo4j-data-modeling at main · neo4j-contrib/mcp-neo4j

Model Context Protocol with Neo4j. Contribute to neo4j-contrib/mcp-neo4j development by creating an account on GitHub.github.com

](https://github.com/neo4j-contrib/mcp-neo4j/tree/main/servers/mcp-neo4j-data-modeling?source=post_page-----56a6fdb1d2f7---------------------------------------)## Configuration

Add the Neo4j Data Modeling MCP server to your client application of choice with the following configuration:

```
{  "mcpServers": {   "neo4j-graph-data-modeling": {       "command": "uvx",       "args": [ "mcp-neo4j-data-modeling@0.1.1" ]    }  }}
```

There are many MCP-compatible clients, such as [Claude Desktop](https://claude.ai/download) and the [Cursor IDE](https://www.cursor.com/). Check out a comprehensive list of [MCP clients](https://modelcontextprotocol.io/clients).

[## Example Clients - Model Context Protocol

A list of applications that support MCP integrationsmodelcontextprotocol.io

](https://modelcontextprotocol.io/clients?source=post_page-----56a6fdb1d2f7---------------------------------------)## Data Modeling Resources

The Neo4j Data Modeling MCP server provides a few agent resources that assist in data modeling and data ingestion. These include the structure of nodes, relationships, and properties used to define a graph data model within the MCP server.

The MCP server also exposes a resource that lays out the process of ingesting data into Neo4j so you can use the Data Modeling MCP server in combination with other ingestion tools.

## Data Modeling Tools

There are various tools exposed by the MCP server, including validation, import/export, visualization, and code-generation tools.

The MCP server offers validation tools for nodes, relationships, and whole data models. These tools take a Python dictionary as input that adheres to the structure defined by the resources discussed above. The dictionary is then converted to Pydantic models, and any errors are returned to the agent so the data model can be corrected.

The tools currently validate features, including:


* Key property existence on nodes
* Duplicate properties, nodes, or relationships
* Relationship source and target existence

The MCP server also provides a tool that generates a configuration you can use to create a [Mermaid](https://mermaid.js.org/) diagram of the data model. Many MCP clients support Mermaid diagrams, so this is useful for quickly visualizing and understanding your data models.

[## Mermaid

Create diagrams and visualizations using text and code.mermaid.js.org

](https://mermaid.js.org/?source=post_page-----56a6fdb1d2f7---------------------------------------)The data models below were generated from the [Survivor Borneo Wiki](https://survivor.fandom.com/wiki/Survivor:_Borneo).

[## Survivor: Borneo

Survivor: Borneo is the first season of Survivor. It was originally broadcast under the name Survivor, but its official…survivor.fandom.com

](https://survivor.fandom.com/wiki/Survivor:_Borneo?source=post_page-----56a6fdb1d2f7---------------------------------------)![Image](https://miro.medium.com/v2/resize:fit:700/1*R1PTNoT7DO-pZXuzFN-dmA.png)

Use the [Arrows.app](https://arrows.app/#/local/id=pGcjyOUdMMfDWRcPnEs1) drawing tool to manually create data models that can then be imported and modified within the client application. AI-generated data models can also be exported to Arrows format via a tool call so you can edit manually within Arrows.

[## Arrows.app

Web-based tool for drawing pictures of graphs, for use in documents or presentations.arrows.app

](https://arrows.app/?source=post_page-----56a6fdb1d2f7---------------------------------------)![Image](https://miro.medium.com/v2/resize:fit:1000/1*ZHhwfTNjOh501YF4zJEF-w.png)

Note the property format in the Arrows data model. This is done to maintain the information generated in the client application. Each property has the following format:

```
<property-name>: <neo4j-type> | <description> | OPTIONAL<key-identifier>
```

The `KEY` portion is optional and should only be provided on a single property for each node or relationship. This is a constraint of the current Data Modeling MCP server build.

The MCP server also provides tools that generate Cypher code to ingest data according to the data model. This code includes the necessary indexes and constraints, as well as the code for ingesting nodes, relationships, and properties.

If the agent also has access to Cypher execution tools, it may use the Neo4j Data Ingest Process resource to inform its ingestion logic.

## An End-To-End Developer Flow

There’s a common process when an agent is using the Data Modeling MCP server for development. This process includes some data discovery within the client application and, optionally, the Neo4j Cypher MCP server for loading and querying the resulting graph.

![Image](https://miro.medium.com/v2/resize:fit:700/1*5gzvxt_atnMR6UmbdCMBGg.png)

In this example, I’ll walk through a quick development session where I used Claude Desktop and the Neo4j Cypher and Data Modeling MCP servers to create a graph of Survivor data from season 1.

We’ll be creating a different graph data model from the one above.

The Claude configuration file I used:

```
{  "mcpServers": {    "mcp-data-modeling": {      "command": "uvx",      "args": [ "mcp-neo4j-data-modeling@0.1.1" ]    },    "mcp-cypher": {      "command": "uvx",      "args": [ "mcp-neo4j-cypher@0.2.3" ],      "env": {        "NEO4J_URL": "bolt://localhost:7687",        "NEO4J_USERNAME": "neo4j",        "NEO4J_PASSWORD": "password",        "NEO4J_DATABASE": "neo4j"      }    }  }}
```

I used a local Neo4j instance via [Neo4j Desktop](https://neo4j.com/download/) to store my resulting graph.

You need to first provide the agent with data and some use cases. This data can be from a website, provided CSV file, or MCP tool call results. Once the agent analyzes the data and understands your use cases, it can begin the modeling process.

I provided Claude with a link to the [Survivor Borneo Wiki](https://survivor.fandom.com/wiki/Survivor:_Borneo) and some use cases I wanted to solve with the graph.

![Image](https://miro.medium.com/v2/resize:fit:700/1*Vwi-BxIrR5SVN80zXkKpXQ.png)

Once Claude understands our data, it will then reference the schema resources exposed by the Data Modeling MCP server to construct a JSON representation of the data model. This will then be passed to the data model validation tool, which will catch any errors in the model. Claude should then fix these errors and prompt for any missing information.

![Image](https://miro.medium.com/v2/resize:fit:1000/1*kKFr7FLijFQ3y9_TEnYM5g.png)

Once a valid data model is generated, Claude can use the Mermaid configuration tool to receive a valid Mermaid configuration. You can then use this to generate a visualization of the data model.

![Image](https://miro.medium.com/v2/resize:fit:1000/1*DnuHg_uAaSwxXyYYLb3F5Q.png)

Many client applications, such as Claude Desktop and Cursor, support Mermaid diagrams.

Once we have the first draft visualized, we can request any modifications to Claude. This will loop over the data model correction → validation → visualization steps.

![Image](https://miro.medium.com/v2/resize:fit:1000/1*kTNsS660N_iOgwciWQTcWg.png)

We’re happy with this data model for our demo purposes, so now we can move on to the ingest phase. The code generation tools provided by the Data Modeling MCP server can be used to ingest data into a Neo4j instance. While the Data Modeling MCP server doesn’t currently connect to a database, you can use the Neo4j Cypher MCP server to run any ingest code in your client application.

Note that ingesting data via Claude Desktop is **not** recommended, but can be good for quick proofs of concept.

![Image](https://miro.medium.com/v2/resize:fit:700/1*OyhfYTnPQtLzXKDlAmotbw.png)

Notice here that Claude chose to only use the constraints Cypher queries the Data Modeling MCP server provides. Sometimes Claude may choose to write its own Cypher code if we don’t explicitly ask it to use the MCP tools.

Finally, you can query your Neo4j database to ensure that data was loaded correctly. You can do this using the Neo4j Cypher MCP server or manually via the Aura console or Neo4j Desktop application.

[## Neo4j Aura

console.neo4j.io

](https://console.neo4j.io/?source=post_page-----56a6fdb1d2f7---------------------------------------)![Image](https://miro.medium.com/v2/resize:fit:700/1*-VOqfVtetuW_GNvRoOC1hA.png)

We can then get detailed answers to our use cases.

**NOTE: Major Survivor Borneo spoilers below**

![Image](https://miro.medium.com/v2/resize:fit:700/1*xDPIygmldcDcfhBoDCBf9w.png)

![Image](https://miro.medium.com/v2/resize:fit:700/1*ozzkNinZKKDdB_x9qdVjGA.png)

![Image](https://miro.medium.com/v2/resize:fit:700/1*bUqUhQnumvgvSrKSwtheTw.png)

## Summary

Data modeling can sometimes be a hurdle when it comes to migrating data to the graph, and the Neo4j Data Modeling MCP server alleviates some of the pain points. You can now easily get a proof of concept complete or iterate on different data model versions with the ability to validate and visualize within the same application. Other MCP servers can also be combined with the Data Modeling MCP server to create end-to-end development workflows that allow you to quickly explore your data as a graph.

You can learn more about the Neo4j Data Modeling MCP server by watching [Jason Koo’s video tutorial](https://youtu.be/dVwUXzst4Vo?feature=shared).

Check out the GitHub repos below.

[## mcp-neo4j/servers/mcp-neo4j-data-modeling at main · neo4j-contrib/mcp-neo4j

Model Context Protocol with Neo4j. Contribute to neo4j-contrib/mcp-neo4j development by creating an account on GitHub.github.com

](https://github.com/neo4j-contrib/mcp-neo4j/tree/main/servers/mcp-neo4j-data-modeling?source=post_page-----56a6fdb1d2f7---------------------------------------)[## mcp-neo4j/servers/mcp-neo4j-cypher at main · neo4j-contrib/mcp-neo4j

Model Context Protocol with Neo4j. Contribute to neo4j-contrib/mcp-neo4j development by creating an account on GitHub.github.com

](https://github.com/neo4j-contrib/mcp-neo4j/tree/main/servers/mcp-neo4j-cypher?source=post_page-----56a6fdb1d2f7---------------------------------------)[Neo4j Data Modeling MCP GitHub Repo](https://github.com/neo4j-contrib/mcp-neo4j/tree/main/servers/mcp-neo4j-data-modeling)

[Neo4j Cypher MCP GitHub Repo](https://github.com/neo4j-contrib/mcp-neo4j/tree/main/servers/mcp-neo4j-cypher)

[Neo4j MCP Servers GitHub Repo](https://github.com/neo4j-contrib/mcp-neo4j)


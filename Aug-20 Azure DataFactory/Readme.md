# Azure Data Factory - Topics Explored

## 1. Pipelines
- Pipelines in Azure Data Factory are groups of activities that perform a task.
- They allow for orchestration and execution of data workflows.
- You can manage dependencies and execute multiple activities sequentially or in parallel.

## 2. Copy Activity
- The Copy Activity in Azure Data Factory is used to copy data from a source to a destination.
- Supports a wide range of data sources and formats.
- Allows for transformations and data mappings during the copy process.

## 3. Expression Builder
- Expression Builder allows you to define expressions to manipulate data.
- It provides a way to create dynamic content based on the variables and parameters.
- Commonly used in activities, mapping data flows, and control flow.

## 4. Difference between Variable & Parameter
- **Variables**:
  - Used within a pipeline to store values.
  - Their scope is limited to the pipeline execution.
  - Values can be changed during pipeline execution.

- **Parameters**:
  - Passed into a pipeline when it's run.
  - Their values are set at the start of the pipeline and cannot be changed during execution.
  - They provide external inputs to the pipeline.

## 5. Bulk Insert
- Bulk Insert is a high-performance method to insert large amounts of data into a database.
- It minimizes transaction logging and uses efficient batch processing.
- Commonly used in scenarios where large datasets need to be loaded into a database quickly.


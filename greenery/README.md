# co:rise Analytics Engineering with dbt

## Course Material

### Week 1
* Understand where dbt fits into the modern data stack, and why it is a core skill for Analytics Engineers
* Run dbt in the command line and save your work to github with git
* Start building a dbt project, and running dbt models against source data in a data warehouse. (This is super cool because being able to do it is foundational to becoming a successful Analytics Engineer!)

### Week 2
* Implement best practices for creating model layers in dbt projects,
* Test data using dbt,
* Defensively code against “bad” data,
* Know which questions to ask about key business metrics using the data we modeled in Week 1, and
* Build model layers and dbt tests into your project

### Week 3
* Use Jinja and macros to create functions with SQL,
* Use Hooks and operations to strategically run SQL and macros without needing to repeat your code, and
* Use dbt packages to install community-built dbt macros, models, and tests 
directly in our projects.

### Week 4
* Understand dbt Snapshots, how they work, and when to use them
* Create a dbt model to answer product funnel questions
* Be able to understand how and when to use dbt exposures
* How dbt can complement traditional data analysis
* Be aware of the various options for running dbt in production
* Understand the various dbt artifacts that are available, and how they can be used

## The Project

**greenery** is a (mock) e-commerce start up that sells plants. As the Analytics Engineer for **greenery**, I have used dbt to transform and model our data to better serve our company. I have prepared the data to be ready for use in BI tools or directly queried to accurately and efficiently answer business inquiries. 

Using dbt's best practices the data has been structured as so:
![greenery dag](Greenery_DAG.png)
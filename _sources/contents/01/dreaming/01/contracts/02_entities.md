# Entities

At first I was a bit surprised to see code, but then I realised that this was somehow defining the basic objects they were going to use to do their analysis. They asked me to focus on the two first blocks of code:

```js
entity Customer
    attributes:
        name: String;

entity Widget
    attributes:
        name: String;
        description: Text;
```

>– *This is the code we used to define the objects we're dealing with on the platform. This language is called AnaLog.* – they said. – *It's a bit like a programming language but is a very minimal one.*
>
>– *Do you use it write the code that runs the platform?* – I asked.
>
>– *Not really... it's not a query language, neither it's used to code the platform itself. It's more of a language for declaring what data assets exists and how it will produce new data assets from it. Don't worry, I'll explain everything.*

## What is an Entity?

>– *This code defines the primitive contracts I'm going to use in my analysis. I asked you to focus on the first two: customers and widgets. Have you noticed what they have in common?*
>
>– *They're both defined with this "entity" keyword.* – I said. – *And they have attributes.*
>
>– *Yes, that's right! Entities are one of the basic types of contracts we can use in our analytics platform. They are the things we want to analyse and make decisions about. Entities are **static and immutable**. They are created once and that's it.*
>
>– *This entity represents our Customers and what immutable attributes are associated with them. Let me show you something...*

They clicked somewhere else and a new window appeared, with a field where they wrote a SQL query and some sample data appeared below it.

::::{admonition} Querying entities.
:::{code-block} sql
  SELECT * FROM Customer LIMIT 5;
:::
:::{table}
| `customer_id` | `created_at`            | `name`                    |
|---------------|-------------------------|---------------------------|
| 1             | 2018-07-22 13:56:23.128 | "Florence Price"          |
| 2             | 2017-02-13 08:22:43.231 | "Scott Joplin"            |
| 3             | 2019-08-05 12:07:06.562 | "George Bridgetower"      |
| 4             | 2021-02-03 03:12:42.245 | "Samuel Coleridge-Taylor" |
| 5             | 2020-09-19 22:42:05.523 | "Joseph Bologne"          |
:::
::::

>– *Wait... is this SQL?* – I asked – *I thought you said this was not a query language.*
>
>– *Yes. The platform work like this: we tell the platform where data is, what primitive data exists, and so one, by defining contracts in AnaLog.The platform runs those contracts and produces data assets which are like tables. We can then query those tables using our simplified flavour of SQL.*
>
>– *Oh, I see... so, the Customer entity is used to produce this table. Is it like a schema definition?*
>
>– *Yes, entity contracts are a bit like a schema, but there are more complex contracts as well. The platform will use this contract to produce a table with the data we need. Our system separates the concerns of declaring data and its transformations that will be ran by the platform from the concern of running queries for analytical purposes. SQL is great for queries, there's no reason to change that! But to describe how datasets are produced it's a bit too powerful. We'd rather have a very strict control of **what kinds** of queries people can run to create datasets. This allows us to control the complexity of the system.*

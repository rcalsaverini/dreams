# Entities



At first I was a bit surprised to see the business analysts writing code, but then I realised that this was somehow defining the basic objects they were going to use to do their analysis. They asked me to focus on the two first blocks of code:

```js
entity Customer
  attributes:
      name: String;

entity Widget
  attributes:
    name: String;
    description: Text;
```

> – _This is the code we used to define the objects we're dealing with on the platform. This language is called AnaLog._ – they said. – _It's a bit like a programming language but is a very minimal one._
>
> – _Is this how you write the code that runs the platform?_ – I asked.
>
> – _Not really... it's not a query language, neither it's used to code the platform itself. It's more of a language for declaring what data assets exists and how to produce new data assets from them. Don't worry, I'll explain everything._

:::{image} /images/entities.png
:alt: What is an Entity?
:width: 320px
:class: bg-primary mb-1
:align: right
:::

## What is an Entity?

> – _This code defines the primitive contracts I'm going to use in my analysis. I asked you to focus on the first two: customers and widgets. Have you noticed what they have in common?_
>
> – _They're both defined with this "entity" keyword._ – I said. – _And they have attributes._
>
> – _Yes, that's right! Entities are one of the basic types of contracts we can use in our analytics platform. They are the things we want to analyse and make decisions about. Entities are **static and immutable**. They are created once and that's it._
>
> – _This entity represents our Customers and what immutable attributes are associated with them. Let me show you something..._

They clicked somewhere else and a new window appeared, with a field where they wrote a SQL query and some sample data appeared below it.

::::{admonition} Querying entities.
:::{code-block} sql
SELECT * FROM Customer LIMIT 5;
:::
:::{table}
| `customer_id` | `created_at` | `name` |
|---------------|-------------------------|---------------------------|
| 1 | 2018-07-22 13:56:23.128 | "Florence Price" |
| 2 | 2017-02-13 08:22:43.231 | "Scott Joplin" |
| 3 | 2019-08-05 12:07:06.562 | "George Bridgetower" |
| 4 | 2021-02-03 03:12:42.245 | "Samuel Coleridge-Taylor" |
| 5 | 2020-09-19 22:42:05.523 | "Joseph Bologne" |
:::
::::

> – _Wait... is this SQL?_ – I asked – _I thought you said this was not a query language._
>
> – _Yes. Entities work like this: we tell the platform where the data for the entities is, and what structure it has by defining contracts in AnaLog. The platform then runs those contracts and produces queriable data assets, which are like SQL tables. We can query those tables using our simplified flavour of SQL._
>
> – _Oh, I see... so, the Customer entity is used to produce this table. Is it like a schema definition?_
>
> – _Yes, entity contracts are a bit like a schema, but there are more complex contracts as well. The platform will use this contract to produce a table with the data we need. Our system separates the concerns of declaring data and its transformations that will be ran by the platform from the concern of running queries for analytical purposes. SQL is great for queries, there's no reason to change that! But to describe how datasets are produced it's a bit too powerful. We'd rather have a very strict control of **what kinds** of queries people can run to create datasets. This allows us to control the complexity of the system._

## What is an Attribute?

> – All entities have, by default, a unique identifier (`customer_id` in the case above) and a creation date (`created_at`). You don't need to declare those fields if they follow the naming conventions. The other fields are what we call **attributes**. They are basic information about an entity, stuff that would never change about it. For example here are some widgets from our blog platform...

::::{admonition} Querying entities.
:::{code-block} sql
SELECT * FROM Widget LIMIT 3;
:::
:::{table}
| `widget_id` | `created_at` | `name` | `description` |
|-------------|-------------------------|--------------|---------------------------------|
| 1 | 2021-06-22 13:56:23.128 | "NEW_POST" | "Button to create new post" |
| 2 | 2021-06-22 13:56:23.128 | "ADD_AUTHOR" | "Button that adds a new author" |
| 3 | 2019-08-05 12:07:06.562 | "LIST_POSTS" | "Button that lists all posts" |
:::
::::

> – _So, widgets are entities as well, but they have a few more attributes. They have a name and a description..._
>
> – _Exactly. Everything that never changes about an entity can be an attribute._
>
> – _What about things that change?_
>
> – _Oh, that's for another time, but to solve that we'll use Event and State contracts. But let's not get ahead of ourselves._

## Where does the data come from?

> – _Ok, so I understood that this is how we define the shape of the data we want to analyse, at least for the immutable stuff. But where does the data actually comes from?_
>
> – _That's a good question. I'm not a specialist, and you can talk to our Analytics Engineer later to get more details, but when I declare an entity I can also say to it where do the data for that schema comes from, look..._

:::{code-block} js
entity Customers2022
  source:
    type: "files"
    extension: "parquet"
    location: "s3:///customers/snapshot/2022/"
  attributes:
      name: String;
:::

> – _This is a static snapshot of our customers in 2022. It's a bunch of parquet files on S3. I just declared a new entity using this and added a source block indicating where I want the data to be fetched from._
>
> – _But why the other entity doesn't have a source block?_
>
> – _We have a bunch of standards already declared somewhere else. The data for that entity comes from our live databases. Depending on the configurations the platform already knows where the data comes from. This makes our lives easier._
>
> – _And what types of sources can it use?_
>
> – _Oh boy... just about anything. We have data that's read from Kafka streams, from databases, from files, pulling data periodically from APIs, and so on. The platform is very flexible in that regard._
>
> – _So... you just declare the source and the shape, and the platform will take care of the rest?_
>
> – _Yep! Cool, right?_

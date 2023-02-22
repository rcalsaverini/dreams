# The Business Analysts

My dream started at an office, with a lot of people working. I was there to start a new job. The first people I met were a group of Business Analysts. One of them approached me and said:

>– *Hey... are you our new hire? I'm doing some work that might interest you...*

They explained to me that they worked in the a team that did analytics for the company's blog platform product. All the time they needed to analyse how well their UX experiments went, and what the impact of the new designs and features had on their customers' experience and the company's profits.

I sat beside them at a desk. They opened a browser, typed [analytics.company.com](http://analytics.company.com) and a website loaded, with a slick interface. They clicked somewhere and a kind of development interface opened. Inside it there was some code.

```js
entity Customer
    attributes:
        name: String;

entity Widget
    attributes:
        name: String;
        description: Text;

event Click 
  entities:
    clicker: Customer;
    clicked: Widget;
```

>– *Take a look* – they said – *this is our analytics platform. This is where we spend most of our time. I'm going to teach you the basics.*
>
>– *This codes defines the primitive contracts I'm going to use in my analysis: customers, widgets and clicks. Let's focus on the customers and widgets for now. Have you noticed what they have in common?*
>
>– *They're both defined with this "entity" keyword.* – I said. – *And they have attributes.*
>
>– *Yes, that's right! Entities are one of the basic types of contracts we can use in our analytics platform. They are the things we want to analyse and make decisions about. Entities are **static and immutable**. They are created once and that's it.*
>
>– *This entity represents our Customers and what immutable attributes are associated with them. Let me show you...*

They clicked on another button and a text field appeared where they wrote a SQL query and some sample data appeared below it.

```{code-block} sql
---
caption: |
    Input here your query...
---
SELECT * FROM Customer LIMIT 5;
```

```{table}
| `customer_id` | `created_at`            | `name`                    |
|---------------|-------------------------|---------------------------|
| 1             | 2018-07-22 13:56:23.128 | "Florence Price"          |
| 2             | 2017-02-13 08:22:43.231 | "Scott Joplin"            |
| 3             | 2019-08-05 12:07:06.562 | "George Bridgetower"      |
| 4             | 2021-02-03 03:12:42.245 | "Samuel Coleridge-Taylor" |
| 5             | 2020-09-19 22:42:05.523 | "Joseph Bologne"          |
```

>– All entities have, by default, a unique identifier (customer_id in this case), and a creation date. It could have additional fields, but they have to be stuff that would never change about the entity. For example here are some widgets from our app...

There are two types of data here: **entities** and **events**. Entities represent static **immutable** information about something. For example, this entity called `Customer` represents a customer's basic immutable information. Check this out...*


```{code-block} sql
---
caption: |
    Input here your query...
---
SELECT * FROM Widget LIMIT 3;
```

```{table}
| `widget_id` | `created_at`            | `name`       | `description`                   |
|-------------|-------------------------|--------------|---------------------------------|
| 1           | 2021-06-22 13:56:23.128 | "NEW_POST"   | "Button to create new post"     |
| 2           | 2021-06-22 13:56:23.128 | "ADD_AUTHOR" | "Button that adds a new author" |
| 3           | 2019-08-05 12:07:06.562 | "LIST_POSTS" | "Button that lists all posts"   |
```

>– Events on the other hand represent things that happened to entities. They are immutable as well, if an event happened, it happened. It can't unhappen. They also have and unique identifier and a creation date, but more importantly, the have relationships!
>
>– What are relationships?
>
>– They are stuff that are the entities affected by the event! For example, this event is a click. Every time a user clicks in a widget of the app, a new event is created here. Check this…


```{code-block} sql
---
caption: |
    Input here your query...
---
SELECT 
    Customer.customer_id,
    Widget.name,
    Click.created_at
FROM Click(Customer, Widget)
WHERE Widget.widget_id = 1
LIMIT 3;
```

```{table}
| `Customer.customer_id` | `Widget.name` | `Click.created_at`  |
|------------------------|---------------|---------------------|
| 262                    | "NEW_POST"    | 2022-06-01 15:31:32 |
| 123                    | "NEW_POST"    | 2022-06-01 15:31:53 |
| 3465                   | "NEW_POST"    | 2022-06-01 15:32:23 |
| 235                    | "NEW_POST"    | 2022-06-01 15:33:01 |
```

>– What's that TotalClicks thing?
>
>– That's a state, that's a transformation or aggregation indexed by entities. You have to declare what are the entities that index it and how to calculate it. Here, let me show it to you.

```js
state TotalClicks
  entities: 
    Customer; 
    Widget;
  
  fields:
    totalClicks: Int;
  
  batch (clicks: List[Click]) {
    this.totalClicks = count(clicks);
  }
  
  update (click: Click) {
    this.totalClicks += 1;
  }
```


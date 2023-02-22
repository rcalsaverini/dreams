# Events

:::{warning}
This is a draft. It's not finished yet.
:::

> – *What about that events thing?*
>
> – *Alright, let's talk about events...*

## What is an Event?

> – Events represent things that happened to entities. They are immutable as well. If an event happened, it happened. It can't unhappen. They also have and unique identifier and a creation date, but more importantly, the have relationships!
>
> – What are relationships?
>
> – They are stuff that are the entities affected by the event! For example, this event is a click. Every time a user clicks in a widget of the app, a new event is created here. Check this…

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

> – What's that TotalClicks thing?
>
> – That's a state, that's a transformation or aggregation indexed by entities. You have to declare what are the entities that index it and how to calculate it. Here, let me show it to you.

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

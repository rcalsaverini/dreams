# Events

## What is an Event?

> – *What about those event thingies?*
>
> – *Alright, let's talk about events! Events represent things that happened to entities. They are immutable as well. If an event happened, it happened. It can't unhappen. They also have and unique identifier and a creation date, but more importantly, the have relationships!*
>
>

They showed me again the code for the event block[^syntax]:

:::{code-block} js
event Click
  entities:
    clicker: Customer;
    clicked: Widget;
:::

> – What are relationships?
>
> – They are the entities affected by the event. For example, this event is a click. Every time a user clicks in a widget of the app, a new event is created here. Check this…

::::{admonition} Querying entities.
:::{code-block} sql
SELECT clicker.customer_id, clicked.name, created_at
FROM Click(clicker, clicked)
WHERE clicked.widget_id = 1
LIMIT 3;
:::
:::{table}
| `clicker.customer_id` | `clicked.name` | `created_at`        |
|-----------------------|----------------|---------------------|
| 262                   | "NEW_POST"     | 2022-06-01 15:31:32 |
| 123                   | "NEW_POST"     | 2022-06-01 15:31:53 |
| 3465                  | "NEW_POST"     | 2022-06-01 15:32:23 |
| 235                   | "NEW_POST"     | 2022-06-01 15:33:01 |
:::
::::

> – *Notice how I did the query. I specified that I wanted to query the Click event, but also the Customer and Widget entities related to each event. I don't have to care about any joins since those relationships are already declared in the definition of the Click event. I don't even know it there is an actual join in the database or if it's just materialized this way. I just know that I can query the Click event and get the Customer and Widget entities related to it.*
>
> – *Oh, so the relationships are like joins with the entities affected by a given event?*
>
> – *Exactly! And the contract metadata informs the platform what the relationships, and the platform itself decides what to do in the background. I don't have to worry if it's a join or a materialized view.*
>
> – *Can events have other kids of information? Like attributes?*
>
> – *Yes! Events can have attributes. Take a look:
>
:::{code-block} js
event PageLoaded:
  entities:
    customer: Customer;
    page: Page;
  attributes:
    referrer: String;
    user-agent: String;
:::

> – *This is an event from our Website. It represents when a user loads a page. It has the user and the page that was loaded, and also the referrer and the user-agent. Let me show you how the data looks like.*

::::{admonition} Querying attributes.
:::{code-block} sql
SELECT customer.customer_id, referrer, created_at
FROM PageLoaded(user, page)
WHERE page.type = "home"
LIMIT 3;
:::
:::{table}
| `customer.customer_id` | `referrer`                                                | `created_at`        |
|------------------------|-----------------------------------------------------------|---------------------|
| 123                    | `"<https://www.google.com/search?q=best+blog+tool+ever>"` | 2022-06-01 15:31:32 |
| 3465                   | `"<https://www.google.com/search?q=I+want+to+blog>"`      | 2022-06-01 15:31:53 |
| 235                    | `"<https://fulano.blog.com/new-cool-blogging-tool>"`      | 2022-06-01 15:32:23 |
:::
::::

> – *Notice that I can query the attributes of the event as well.*
>
> – *That's cool! Can you do joins that are not declared in the event's contract?*
>
> – I can do explicit joins when *querying* the data after it was processed by the ETL.  I can do it like this:

::::{admonition} Querying with explicit joins.
:::{code-block} sql
SELECT page_customer.customer_id, page.name, Account.account_id, PageLoaded.created_at
FROM PageLoaded(page_customer, page) JOIN Account(account_customer) ON page_customer.customer_id = account_customer.customer_id
WHERE page.type = "home"
LIMIT 3;
:::
:::{table}
| `page_customer.customer_id` | `page.name` | `account_customer.account_id` | `PageLoaded.created_at` |
|-----------------------------|-------------|-------------------------------|-------------------------|
| 123                         | "home"      | 23263                         | 2022-06-01 15:31:32     |
| 3465                        | "home"      | 523426                        | 2022-06-01 15:31:53     |
| 235                         | "home"      | 2342                          | 2022-06-01 15:32:23     |
:::
::::

> – *It's not advised though since that is onerous and expensive. It's better to declare the relationships in the event's contract. That way the platform can optimize everything when building the data assets and make it more efficient. But if you need to do it, you can. We avoid doing that in automated processes, but we sometimes do it in ad-hoc queries. If we need to do it too often, that's a sign that we need to improve the contracts.*
>
> – *I see! You don't use explicit joins in the contracts also, right?*
>
> – *Nope! There are no ways of defining explicit joins when defining the data assets. The idea of AnaLog is that if I need a different view of the data, with different joins, I create a new data asset. That way we limit how expensive are the datasets created by the users. It's a limitation, but it's not a severe one. On most cases business analysts like us don't need overly complicated queries. And you'll see that States solve most of the problems we have.*
>
> – *What about left joins?*
>
> – *Left joins are just optional relationships. For example, this is a contract from our billing system with an optional relationship. We have a referral program where we give a discount to customers that refer other customers. So, when a customer is created, we check if there is a referral code in the request.*
>

::::{admonition} Optional relationships.
:::{code-block} js
event CustomerCreated:
  entities:
    customer: Customer;
    referrer: Customer?; // optional relationship
:::
:::{code-block} sql
SELECT customer.customer_id, referrer.customer_id, created_at
FROM CustomerCreated(customer, referrer)
LIMIT 3;
:::
:::{table}
| `customer.customer_id` | `referrer.customer_id` | `created_at`        |
|------------------------|------------------------|---------------------|
| 123                    | 3465                   | 2022-06-01 15:31:32 |
| 3465                   | -                      | 2022-06-01 15:31:53 |
| 235                    | -                      | 2022-06-01 15:32:23 |
::::

> – *Notice that the `referrer` column is nullable. That's because the relationship is optional. If there is no referrer, the column will be null, just like a left join.*
>
> – *That's cool! What about the state stuff? I saw some more involved code there... What is it for?*
>
> – *Yeah, it's time to talk about states. They are the secret sauce of this platform."

[^syntax]:  I'm still not sure of the best syntax for this. I'm considering using the `entities` keyword, but I'm also considering using `relationships` instead. I'm also considering declaring relationships like this `event Click(clicker: Customer, clicked: Widget)` or even `event Click {clicker: Customer, clicked: Widget}`. I'm not sure yet.

# The Business Analysts

The first people I met were a group of Business Analysts. They worked in the a team that did analytics for the company's app. All the time they needed to analyse how well their UX experiments went, and what the impact of the new designs and features had on their customers' experience and the company's profits.

One of them approached me and said:

– Hey... are you the new BA? C'mon here, I'm doing some work that might interest you.

I sat beside them at a desk. They opened a browser, typed [analytics.platform](http://analytics.platform) and a website loaded, with a slick interface. They clicked a button and a kind of development interface opened. Inside it there was some code.

```{code-block}
entity Customer
    attributes:
        name: String;
        client_since: Date;

entity Widget
    attributes:
        name: String;
        description: Text;

event Click 
  entities:
    clicker: Customer;
    clicked: Widget;
```

– Take a look – they said – this is our analytics platform. This is where we spend most of our time. I'm going to teach you the basics.

– This codes defines the most primitive contracts about the data we're going to use today. There are two types of data here: *entities* and *events*. Entities represent static **immutable** information about something. For example, this entity called `Customer` represents a customer's basic immutable information. Check this out...

They clicked on another button and a text field appeared where they wrote a SQL query and some sample data appeared below it.

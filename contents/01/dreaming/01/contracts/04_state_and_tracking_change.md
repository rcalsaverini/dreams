# State and tracking change

:::{warning}
This is a draft. It's not finished yet.
:::

> – _What's that TotalClicks thing?_
>
> – _That's a state, that's a transformation or aggregation indexed by entities. You have to declare what are the entities that index it and how to calculate it. Here, let me show it to you._

:::{code-block} js
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
:::

> – _Ok, so let's talk about Event and State contracts now._ 
>
> – _You mentioned before that these are used for things that change, right?_
>
> – _Exactly. When we want to track changes in our data, we use these contracts._
>
> – _And how do they work?_
>
> – _Let me show you an example. This is an Event contract that I just wrote:_

:::{code-block} js
event Click
  entities:
    clicker: Customer;
    clicked: Widget;
:::

> – _So, this event is called Click, and it involves two entities: clicker and clicked. The clicker is a Customer entity, and the clicked is a Widget entity. Whenever someone clicks on a widget, we want to capture that event and record who clicked and what widget was clicked._
>
> – _That makes sense. But how do we keep track of all those clicks?_
>
> – _That's where the State contract comes in. Let me show you an example of a State contract that tracks the total number of clicks for each customer and widget:_

:::{code-block} js
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
:::{code-block} js

> – _So, this state contract is called TotalClicks, and it involves two entities: Customer and Widget. It also has a field called totalClicks, which is an integer that keeps track of the total number of clicks for each customer and widget._
>
> – _I see. And how does it work?_
>
> – _The State contract has two methods: batch and update. The batch method is used to initialize the state with a batch of events, and the update method is used to update the state when a new event occurs._
>
> – _So, in this example, the batch method takes a list of Click events and initializes the totalClicks field for each customer and widget. The update method is called every time a new Click event occurs, and it increments the totalClicks field for the customer and widget associated with that event._
>
> – _That's really cool! So we can use Event and State contracts to keep track of any kind of change in our data._
>
> – _Yes, that's right. And the best part is that the Analytics Platform takes care of all the heavy lifting. We just need to define the contracts, and the platform will take care of processing the data and keeping the state up-to-date._

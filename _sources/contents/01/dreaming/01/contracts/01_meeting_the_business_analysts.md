# The Business Analysts

:::{image} /images/bas.png
:alt: Meeting the Business Analysts
:width: 320px
:class: bg-primary mb-1
:align: right
:::

The first people I met were a team of Business Analysts. One of them approached me and said:

>– *Hey... are you our new hire?*
>
>– *Yes, I am. I'm the new platform engineer!*
>
>– *Great! I'm doing some work using the Analytics Platform! That might interest you...*

They explained to me that they worked in the a team that did analytics for the company's blog platform product. All the time they needed to analyse how well their UX experiments went, and what the impact of the new designs and features had on their customers' experience and the company's profits.

I sat beside them at a desk. They opened a browser, typed [analytics.company.com](http://analytics.company.com) and a website loaded, with a slick interface. They clicked somewhere and a kind of development interface opened. Inside it there was some code.

:::{code-block} js
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

>– *Take a look* – they said – *this is our analytics platform. This is where we spend most of our time. I'm going to teach you the basics.*

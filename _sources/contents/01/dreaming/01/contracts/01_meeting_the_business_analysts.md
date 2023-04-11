# The Business Analysts

:::{image} /images/bas.png
:alt: Meeting the Business Analysts
:width: 320px
:class: bg-primary mb-1
:align: right
:::

Upon my arrival, I was greeted by a team of Business Analysts. One of them approached me with a warm smile and said:

> – *Hey... are you our new hire?*
>
> – *Yes, I am. I'm the new platform engineer!*
>
> – *Great! I'm working on some projects using the Analytics Platform! That might interest you...*

The team explained that they were responsible for analytics related to the company's blog platform product. Their work involved analyzing the effectiveness of UX experiments, as well as assessing the impact of new designs and features on customer experience and company profits.

I took a seat beside them at a desk. They opened a web browser, typed [analytics.company.com](/#), and a sleek website loaded. After a few clicks, a development interface appeared on the screen, displaying some code.

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

> – *Take a look,* – they said – *this is our analytics platform. This is where we spend most of our time. Let me show you the basics.*

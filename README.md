# Guestlist Gem

[Guestlist](http://guestlistapp.com) is a hosted ticketing service. Use this 
gem to grab events data, ticket orders, and other swanky info from Guestlist's 
API. 

I've been told that the Guestlist API itself is still under development, 
so consider this ample warning that things are unstable around here. You have
been warned, young Will Robinson!

## Installation

Add to your Gemfile and run the `bundle` command to install it.

  ```ruby
gem "guestlist", :git => "git://github.com/rocketscientist/guestlist.git"
  ```

## Initialization

If you're using Rails, `config/initializers/guestlist.rb`
is a good place to put this:

    Guestlist.configure do |config|
      config.username = 'your.email@somewhere.com'
      config.password = 'super-duper-secret-word'
    end

## Enabling API Access

Currently, the API is accessible when you ask for it. Submit a support
ticket and thank them when API access is enabled for your account.

You can fetch data from events created through the Guestlist
admin panel. When you've created an event, make a note of the `event_id` 
You can find your `event_id` from the API endpoint under the "API" tab in 
Event Settings.

Your endpoint will look something like `http://guestlistapp.com/api/v0.1/events/28374/orders`
which means your `event_id` is `28374`.

## Usage

Return the event's name:

    Guestlist.event('28374').name
    # => "Cheese Party"

Return the event's start/stop datetime and timezone:

    Guestlist.event('28374').start
    # => "2012/04/01 01:30:00 +0000"
    Guestlist.event('28374').timezone
    # => "Eastern Time (US & Canada)"

Return the event's description:

    Guestlist.event('28374').description
    # => "<p>This is going to be a great party. We've got lots of cheeses: cheddar, blue, havarti, and many more.</p>"

Note: the `description` method returns raw HTML.

These methods return total ticket counts across all ticket types:

    Guestlist.event('28374').total_tickets_sold
    # => 6
    Guestlist.event('28374').total_tickets_remaining
    # => 94
    Guestlist.event('28374').total_tickets_quantity
    # => 100

## Todos

There's an endpoint for retrieving orders for a given event. I haven't done anything
with this so you're welcome to fork and send me a pull request.



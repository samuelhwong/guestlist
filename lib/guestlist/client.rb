require 'guestlist/rest_client'
require 'guestlist/event'

module Guestlist
  # Wrapper for the Guestlist REST API.

  class Client < Guestlist::RestClient
    # Public method that fetches an event's data
    # and data from its associated objects (i.e. ticket_types)
    def event(id)
      code, ev = GET("/events/#{id}")
      @event = Guestlist::Event.new(ev)
      @event.ticket_types = fetch_ticket_types
      return @event
    end

    private

    # Returns an array of ticket_types.
    #
    # The Guestlist API `ticket_types` endpoint returns a list
    # of URLs that point to a particular ticket type object.
    # We iterate through this list to assembly an Array of 
    # ticket types.
    def fetch_ticket_types
      result = Array.new
      code, tt = GET("/events/#{@event.id}/ticket_types")
      tt['ticket_types'].each do |type_url|
        # Strip the root from the fetched URL.
        type_url["#{@api_url}"]=""
        code, data = GET("#{type_url}")
        result << data
      end
      return result
    end
  end
end

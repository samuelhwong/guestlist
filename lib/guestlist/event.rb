require 'guestlist/base'
require 'guestlist/client'

module Guestlist
  class Event < Guestlist::Base
    lazy_attr_reader :id, :name, :description, :start, :stop, :timezone

    attr_accessor :ticket_types

    # Sum of all unclaimed tickets, across all ticket_types.
    def total_tickets_remaining
      total_remaining = total_tickets_quantity - total_tickets_sold
      return total_remaining
    end

    # Sum of all tickets that have been sold, across all ticket_types.
    def total_tickets_sold
      total_sold = 0
      @ticket_types.each do |tt|
        total_sold += tt['tickets_sold']
      end
      return total_sold
    end

    # Tickets quantity = Tickets remaining + Tickets sold
    def total_tickets_quantity
      total_quantity = 0
      @ticket_types.each do |tt|
        total_quantity += tt['tickets_quantity']
      end
      return total_quantity
    end
  end
end

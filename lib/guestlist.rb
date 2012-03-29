require "guestlist/version"
require 'guestlist/client'

module Guestlist
  class << self
    attr_accessor :username, :password

    # Alias for Guestlist::Client
    #
    # @return [Guestlist::Client]
    def new
      @client = Guestlist::Client.new(@username, @password)
    end

    # Enables the initializers/guestlist.rb to set
    # username and password.
    def configure
      yield self
    end

    # Delegate to Guestlist::Client so we can make calls like
    # Guestlist.event('1234').
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end

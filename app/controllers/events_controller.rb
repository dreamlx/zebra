class EventsController < ApplicationController

  def index
    @events = Event.all
    @events_grid = initialize_grid(Event,
      name: 'events_grid')
  end
end

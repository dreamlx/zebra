class EventsController < ApplicationController
  # skip_load_and_authorize_resource :only => [:new, :create]
  # skip_before_action :logged_in_admin, :only => [:new, :create]

  def index
    # current_user = Admin.first
    @events = Event.all
    @events_grid = initialize_grid(Event,
      name: 'events_grid')
  end

  def show
    @event = Event.find(params[:id])
  end
end

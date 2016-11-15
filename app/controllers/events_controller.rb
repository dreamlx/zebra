class EventsController < ApplicationController
  # skip_load_and_authorize_resource :only => [:new, :create]
  # skip_before_action :logged_in_admin, :only => [:new, :create]

  def index
    # current_user = Admin.first
    @events = Event.all
    @events_grid = initialize_grid(Event,
      name: 'events_grid',
      per_page: 15)
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html { render layout: false }
    end
  end
end

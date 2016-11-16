class EventsController < ApplicationController
  # skip_load_and_authorize_resource :only => [:new, :create]
  # skip_before_action :logged_in_admin, :only => [:new, :create]

  def index
    # current_user = Admin.first
    @events = Event.all
    @events_grid = initialize_grid(Event,
      name: 'events_grid',
      per_page: 12)
  end

  def show
    @event = Event.find(params[:id])
    @count = Count.first
    @count.current_num = @count.current_num + 1
    @count.save
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def reset_count
    Count.create(current_num: 0) if (Count.all.count == 0)
    @count = Count.first
    @count.current_num = 0
    @count.save

    redirect_to events_path
  end
end

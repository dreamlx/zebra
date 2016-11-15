class TestsController < ApplicationController
  skip_load_and_authorize_resource :only => [:index]
  skip_before_action :logged_in_admin, :only => [:index]

  def index
    # current_user = Admin.first
    @tests = Test.all

    respond_to do |format|
      format.html { render layout: false }
    end
  end
end

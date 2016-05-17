class SessionsController < ApplicationController
  layout "login"
  skip_before_action :logged_in_admin, only: [:new, :create]
  def new
    
    @admin = Admin.new
  end

  def create
    
    admin = Admin.find_by(email: params[:session][:email])
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_to root_url
    else
      flash.now[:danger] = t(:invalid_name_or_password)
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end
end

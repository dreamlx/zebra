class AdminsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:new, :create]
  skip_before_action :logged_in_admin, :only => [:new, :create]

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      log_in(@admin)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      redirect_to admins_url
    else
      render 'edit'
    end
  end

  def destroy
    Admin.find(params[:id]).destroy
    redirect_to admins_url
  end

  def confirm
    @admin = Admin.find(params[:id])
    @admin.confirm
    redirect_to root_url
  end

  def deny
    @admin = Admin.find(params[:id])
    @admin.deny
    redirect_to root_url
  end

  private
   def admin_params
    params.require(:admin).permit(
      :name, :password, :password_confirmation, :address, :cell, :contact, :email, :website)
   end
end

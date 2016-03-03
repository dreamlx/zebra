class AdminsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :new

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admins_url
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

  private
   def admin_params
    params.require(:admin).permit(
      :name, :password, :password_confirmation, :address, :cell, :contact, :email, :website)
   end
end

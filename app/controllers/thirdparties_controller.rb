class ThirdpartiesController < ApplicationController
  load_and_authorize_resource

  def index
    @thirdparties = Thirdparty.all
  end

  def new
    @thirdparty = Thirdparty.new
  end

  def show
    @thirdparty = Thirdparty.find(params[:id])
  end

  def create
    @thirdparty = Thirdparty.new(thirdparty_params)
    if @thirdparty.save
      redirect_to thirdparties_url
    else
      render 'new'
    end
  end

  def edit
    @thirdparty = Thirdparty.find(params[:id])
  end

  def update
    @thirdparty = Thirdparty.find(params[:id])
    if @thirdparty.update(thirdparty_params)
      redirect_to thirdparties_url
    else
      render 'edit'
    end
  end

  def destroy
    Thirdparty.find(params[:id]).destroy
    redirect_to thirdparties_url
  end

  private
   def thirdparty_params
    params.require(:thirdparty).permit(
      :code, :name, :state, :image)
   end
end

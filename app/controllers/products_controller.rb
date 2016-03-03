class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = Product.where(:admin_id => current_user.id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.admin_id = current_user.id
    if @product.save
      redirect_to products_url
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_url
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_url
  end

  private
   def product_params
    params.require(:product).permit(
      :product_name, :product_image, :admin_id)
   end
end

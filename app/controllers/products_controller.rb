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

  def create_multiple
    @product = Product.find(params[:id])
    params[:product][:how_many].to_i.times do |serial|
      @serial = Serial.create(product_id: params[:product][:product_id], serial_no: Digest::MD5.hexdigest(current_user.id.to_s).upcase + '-' + Time.now.to_f.to_s)
      qr_code(@serial.id)
    end
    redirect_to @product
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
      :product_name, :product_image, :admin_id, :how_many)
   end
end

class ExtentionsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @extention = product.extentions.build(extention_params)
    @extention.save
    redirect_to product
  end

  def update
    @extention = Roi.find(params[:id])
    @extention.update(extention_params)
    respond_to do |format|
      format.json { respond_with_bip(@extention) }
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    product.extentions.find(params[:id]).destroy
    redirect_to product
  end

  private
    def extention_params
      params.require(:extention).permit(
        :extention_name, :extention_type, :extention_value)
    end
end

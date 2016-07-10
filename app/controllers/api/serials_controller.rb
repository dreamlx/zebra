class Api::SerialsController < Api::BaseController
  before_action :authenticate_user!, only: [:show, :confirm_action]

  def show
    @serial = Serial.find_by(id: params[:id])
  end

  def confirm_action
    serial = Serial.find_by(serial_no: params["serial_no"])
    shop_store = ShopStore.find_by(code: params["decode"])
    if serial && shop_store
      @order = Order.new(
        shop_store_id: shop_store.id,
        serial_id: serial.id,
        order_date: Time.now)
      if @order.save
        render json: {:result => true}, status: 200
      end
    else
      render json: {:result => false}, status: 422
    end
  end

  private
    def serial_params
     params.require(:serial).permit(:open_id, :phone, :user_id, :serial_no, :product_id, :state, :store_assistant_id)
    end
end

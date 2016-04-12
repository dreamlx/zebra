class SerialsController < ApplicationController
  skip_before_action :logged_in_admin, only: [:scan, :build_serial]

  def index
    @serials = Serial.all
  end

  def new
    @serial = Serial.new
  end

  def create
    @serial = Serial.new(serial_params)
    if @serial.save
      redirect_to serials_url
    else
      render 'new'
    end
  end

  def edit
    @serial = Serial.find(params[:id])
  end

  def update
    @serial = Serial.find(params[:id])
    if @serial.update(serial_params)
      redirect_to serials_url
    else
      render 'edit'
    end
  end

  def destroy
    Serial.find(params[:id]).destroy
    redirect_to serials_url
  end

  def scan
    user = User.find_by(cell: params["cell"])
    serial = Serial.find_by(serial_no: params["serial_no"])

    if user.nil?
      user = User.create(cell: params[:cell], score: 0)
    end

    if user && serial.state == "未绑定"
      serial.update_attribute(:phone, params["cell"])
      serial.update_attribute(:user_id, user.id)
      user.update_attribute(:score, (user.score + 20 if user.score) || 20)
      serial.scan
      Scanlog.create(user_id: user.id, serial_id: serial.id, current_score: user.score)
      render json: {:return => "1", :userid => user.id, :desc => "绑定成功"}, status: 200
    else
      render json: {:return => "0", :userid => serial.user_id, :desc => "绑定失败"}, status: 422
    end
  end

  def build_serial
    serial = Serial.find_by(serial_no: params["serial_no"])
    if serial
      render json: {:return => "1", :desc => "序列号已存在", :product => serial.product.product_name, :product_logo => serial.product.product_logo, :product_image => serial.product.product_image, :cell => serial.phone, :datetime => serial.created_at}, status: 200
    else
      render json: {:return => "0", :desc => "序列号不存在", :product => nil, :product_logo => nil, :product_image => nil, :cell => nil, :datetime => nil}, status: 422
    end
    #
    # if serial.nil?
    #   serial = Serial.create(serial_no: params["serial_no"], phone: params["cell"])
    # end
    # if serial
    #   render json: {:return => "1", :desc => "绑定成功", :cell => serial.phone, :datetime => serial.created_at}, status: 200
    # else
    #   render json: {:return => "0", :desc => "未绑定"}, status: 422
    # end
  end

  def scan_old
    user = User.find_by(openid: params["openid"])
    serial = Serial.find_by(serial_no: params["serial_no"])
    # if serial
    #   if serial.open_id == params["openid"].to_s
    #     render json: {:return => "3", :desc => "你已经扫过"}, status: 200
    #   elsif serial.open_id && serial.open_id != params["openid"].to_s
    #     render json: {:return => "3", :desc => "你已经扫过"}, status: 200
    #   end
    # elsif serial && serial.open_id.nil?
    #   serial.update_attribute(:open_id, params["openid"])
    #   serial.update_attribute(:user_id, user.id)
    #   render json: {:return => "2", :desc => "成功"}, status: 200
    # else
    #   render json: {:return => "1", :desc => "序列号不存在"}, status: 200
    # end
    if user.nil?
      user = User.create(
        openid: params[:openid],
        score: 0)
    end
    if serial && serial.open_id == params["openid"].to_s
      render json: {:return => "2", :desc => "你已经扫过"}, status: 200
    end
    if serial && serial.open_id != params["openid"].to_s && serial.open_id
      render json: {:return => "3", :desc => "别人已经扫过"}, status: 200
    end
    if user && serial.nil? #&& serial.open_id.nil?
      serial = Serial.create(user_id: user.id, open_id: params["openid"], serial_no: params["serial_no"])
      # serial.update_attribute(:open_id, params["openid"])
      # serial.update_attribute(:user_id, user.id)
      user.update_attribute(:score, (user.score + 20 if user.score) || 20)
      render json: {:return => "1", :desc => "成功"}, status: 200
    end
    # if serial.nil?
    #   render json: {}, status: 422
    # end
  end

  private
   def serial_params
    params.require(:serial).permit(:open_id, :phone, :user_id, :serial_no, :product_id, :state)
   end
end

class SerialsController < ApplicationController
  skip_before_action :logged_in_admin, only: [:scan]

  def scan
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
    if serial && serial.open_id == params["openid"].to_s
      render json: {:return => "2", :desc => "你已经扫过"}, status: 200
    end
    if serial && serial.open_id != params["openid"].to_s && serial.open_id
      render json: {:return => "3", :desc => "别人已经扫过"}, status: 200
    end
    if user && serial && serial.open_id.nil?
      serial.update_attribute(:open_id, params["openid"])
      serial.update_attribute(:user_id, user.id)
      user.update_attribute(:score, user.score+200)
      render json: {:return => "1", :desc => "成功"}, status: 200
    end
    if serial.nil?
      render json: {}, status: 422
    end
  end

  private
   def serial_params
    params.require(:serial).permit(:open_id, :phone, :user_id, :serial_no)
   end
end

class UsersController < ApplicationController
  skip_before_action :logged_in_admin, only: [:weixin]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.name = Rumoji.encode(params[:user][:name])
    if @user.save
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.name = Rumoji.encode(params[:user][:name])
    if @user.update(user_params)
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  def weixin
    uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}&code=#{params[:code]}&grant_type=authorization_code")
    res = Net::HTTP.get_response(uri)
    json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))
    info_uri = URI("https://api.weixin.qq.com/sns/userinfo?access_token=#{json["access_token"]}&openid=#{json["openid"]}&lang=zh_CN")
    info_res = Net::HTTP.get_response(info_uri)
    info_json =  JSON.parse(info_res.body.gsub(/[\u0000-\u001f]+/, ''))
    user = User.find_by(openid: info_json["openid"])
    if user
    else
      user = User.create(
        openid: info_json["openid"],
        name: Rumoji.encode(info_json["nickname"]))
    end
    redirect_to "/activity.html?openid=#{user.openid}&state=#{user.state}"
  end
  
  private
   def user_params
    params.require(:user).permit(:openid, :cell, :name)
   end
end
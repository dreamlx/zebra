class UsersController < ApplicationController
  skip_before_action :logged_in_admin, only: [:userbinding, :userscore, :sns_oauth2, :sns_userinfo, :ticket, :token]
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

  def userbinding
    # uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}&code=#{params[:code]}&grant_type=authorization_code")
    # res = Net::HTTP.get_response(uri)
    # json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))
    # info_uri = URI("https://api.weixin.qq.com/sns/userinfo?access_token=#{json["access_token"]}&openid=#{json["openid"]}&lang=zh_CN")
    # info_res = Net::HTTP.get_response(info_uri)
    # info_json =  JSON.parse(info_res.body.gsub(/[\u0000-\u001f]+/, ''))


    user = User.find_by(openid: params["cell"])
    if user
      user.update_attribute(:cell, params[:cell], :openid, params["openid"])
      render json: {:status => "1"}, status: 200
    else
      # if !params["openid"].nil?
      #   user = User.create(
      #     # openid: info_json["openid"],
      #     # name: Rumoji.encode(info_json["nickname"]))
      #     openid: params[:openid],
      #     name: params[:name],
      #     cell: params[:cell],
      #     score: 0)
      #   render json: {:status => "1"}, status: 200
      # else
        render json: {:status => "0"}, status: 422
      # end
    end
    # redirect_to "/activity.html?openid=#{user.openid}&state=#{user.state}"
  end

  def userscore
    user = User.find_by(openid: params["cell"])
    if user
      if !user.cell.nil?
        render json: {:cell => user.cell, :score => user.score}, status: 200
      else
        render json: {:cell => "", :score => user.score}, status: 200
      end
    else
      render json: {}, status: 422
    end
  end

  def sns_oauth2
    uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}&code=#{params[:code]}&grant_type=authorization_code")
    Rails.logger.task.info "new uri, #{uri}"
    res = Net::HTTP.get_response(uri)
    json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))

    if json
      render json: json, status: 200
    end
  end

  def sns_userinfo
    info_uri = URI("https://api.weixin.qq.com/sns/userinfo?access_token=#{params[:access_token]}&openid=#{params[:openid]}&lang=zh_CN")
    info_res = Net::HTTP.get_response(info_uri)
    info_json =  JSON.parse(info_res.body.gsub(/[\u0000-\u001f]+/, ''))

    if info_json
      render json: info_json, status: 200
    end
  end

  def ticket
    uri = URI("http://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=#{params[:access_token]}")
    res = Net::HTTP.get_response(uri)
    json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))

    if json
      render json: json, status: 200
    end
  end

  def token
    uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}")
    res = Net::HTTP.get_response(uri)
    json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))

    if json
      render json: json, status: 200
    end
  end

  private
   def user_params
    params.require(:user).permit(:openid, :cell, :name, :score)
   end
end

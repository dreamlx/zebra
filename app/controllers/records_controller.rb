class RecordsController < ApplicationController
  skip_before_action :logged_in_admin, only: [:weixin]
  def weixin
    user = User.find_by(openid: params[:record][:openid])
    
    return render json: {message: "谢谢参与", code: nil} if user.nil? # no user found
    
    return render json: {message: "谢谢参与", code: nil} if user.state == 1 # no user found

    user.update(cell: params[:record][:cell], state: 1)
    prize_city = Prize.find_by(city: params[:record][:city])
    
    return render json: {message: "谢谢参与", code: nil} if prize_city.nil? # can not find city

    item = Record::ITEMS.sample
    balance = prize_city.send(item) - Record.where(city: params[:record][:city], prize: Prize.human_attribute_name(item)).count
    return render json: {message: "谢谢参与", code: nil} if balance <= 0  # no balance in this item

    if rand((1/prize_city.send("#{item}_ratio")).to_i) == rand((1/prize_city.send("#{item}_ratio")).to_i)
      record = Record.create(
        city: params[:record][:city],
        prize: Prize.human_attribute_name(item),
        user_id: user.id,
        code: rand(100000..999999),
        state: '未领取')
      return render json: {message: record.prize, code: record.code}, status: 201
    else
      return render json: {message: "谢谢参与", code: nil}
    end
  end

  def index
    @q = Record.ransack(params[:q])
    @records = @q.result.page(params[:page])
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to records_url
    else
      render 'new'
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to records_url
    else
      render 'edit'
    end
  end

  def destroy
    Record.find(params[:id]).destroy
    redirect_to records_url
  end

  def receive
    Record.find(params[:id]).update(state: "已领取")
    redirect_to records_url
  end

  private
    def record_params
      params.require(:record).permit(:user_id, :city, :prize, :code)
    end
end
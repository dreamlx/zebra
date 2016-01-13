class PrizesController < ApplicationController
  def index
    @prizes = Prize.all
  end

  def new
    @prize = Prize.new
  end

  def create
    @prize = Prize.new(prize_params)
    if @prize.save
      redirect_to prizes_url
    else
      render 'new'
    end
  end

  def edit
    @prize = Prize.find(params[:id])
  end

  def update
    @prize = Prize.find(params[:id])
    if @prize.update(prize_params)
      redirect_to prizes_url
    else
      render 'edit'
    end
  end

  private
    def prize_params
      params.require(:prize).permit(
        :city, :free_charge, :free_charge_ratio, :fifty_discount,
        :fifty_discount_ratio, :thirty_discount, :thirty_discount_ratio,
        :ten_discount, :ten_discount_ratio, :red_envelop,
        :red_envelop_ratio)
    end
end
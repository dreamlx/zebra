class Api::UsersController < Api::BaseController
  before_action :authenticate_user!, only: [:all_investors, :update, :show]
  def create
    return api_error(status: 422) if params[:user].nil?

    # verify the cell code, return if no code or not match
    cell_code = CellCode.find_by(cell: params[:user][:cell])
    unless cell_code && cell_code.code && (cell_code.code == params[:user][:code]) && ((cell_code.created_at + 1.hour) > DateTime.now )
      return api_error(status: 422)
    end

    @user = User.new(open_id: params[:user][:open_id], cell: params[:user][:cell])
    if @user.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  def show
    @user = current_user
  end

  def update
    # return api_error(status: 422) if params[:user].nil?
    @user = User.find_by(id: params[:id])
    return api_error(status: 422) if @user.nil?

    @user.image = parse_image_data(params[:image]) if params[:image]

    if @user.update(user_params)
      @user.submit
      render 'show'
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end


  private
    def user_params
      params.permit(:openid, :cell, :name, :score, :image)
    end
end

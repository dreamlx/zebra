class Api::UsersController < Api::BaseController
  # before_action :authenticate_user!, only: [:all_investors, :update, :show]
  def create
    return api_error(status: 422) if params[:user].nil?

    # verify the cell code, return if no code or not match
    # cell_code = CellCode.find_by(cell: params[:user][:cell])
    # unless cell_code && cell_code.code && (cell_code.code == params[:user][:code]) && ((cell_code.created_at + 1.hour) > DateTime.now )
    #   return api_error(status: 422)
    # end

    @user = User.new(open_id: nil, cell: params[:user][:cell])
    if @user.save
      render json: {:result => true}, status: 201
    else
      render json: {:result => false}, status: 201
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

  def send_code
    # create a random code, not unique
    code = rand(1000..9999)
    cell = params[:cell]
    # if succeed to send code, save the cell and code in table of cell_codes
    if User.send_code(cell, code)
      CellCode.where(cell: cell).delete_all
      CellCode.create(cell: cell, code: code)
      render json: {:result => true}, status: 200
    else
      return api_error(status: 422)
    end
  end


  private
    def user_params
      params.permit(:openid, :cell, :name, :score, :image)
    end
end

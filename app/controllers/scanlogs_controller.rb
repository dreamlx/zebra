class ScanlogsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @scanlogs = @user.scanlogs
  end

  private
   def scanlog_params
    params.require(:scanlog).permit(:user_id, :serial_id, :current_score)
   end
end

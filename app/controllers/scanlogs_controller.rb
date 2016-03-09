class ScanlogsController < ApplicationController
  
  private
   def scanlog_params
    params.require(:scanlog).permit(:user_id, :serial_id, :current_score)
   end
end

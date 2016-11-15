class Api::TestsController < Api::BaseController

  def submit
    if params[:entry]
      Test.find_or_create_by(form: params[:form],
                             form_name: params[:form_name],
                             serial_number: params[:entry][:serial_number],
                             field_1: params[:entry][:field_1],
                             field_5: params[:entry][:field_5],
                             field_6: params[:entry][:field_6],
                             field_7: params[:entry][:field_7],
                             field_8: params[:entry][:field_8],
                             field_9: params[:entry][:field_9],
                             creator_name: params[:entry][:creator_name])
      render json: {}, status: 200
    else
      return api_error(status: 401)
    end
  end
end

#
# Test.find_or_create_by(form: params["form"],
#                        form_name: params["form_name"],
#                        serial_number: params["entry"]["serial_number"],
#                        field_1: params["entry"]["field_1"],
#                        field_5: params["entry"]["field_5"],
#                        field_6: params["entry"]["field_6"],
#                        field_7: params["entry"]["field_7"],
#                        field_8: params["entry"]["field_8"],
#                        field_9: params["entry"]["field_9"],
#                        creator_name: params["entry"]["creator_name"])

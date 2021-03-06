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

# raw = "{\x22form\x22:\x22IDsWEJ\x22,\x22form_name\x22:\x22\xE5\x89\x8D\xE5\xAD\x95\xE5\xA6\x88\xE5\xA6\x88\xE5\xB0\x8F\xE6\xB5\x8B\xE8\xAF\x95\x22,\x22entry\x22:{\x22serial_number\x22:5,\x22field_1\x22:\x22\xE7\x94\xB7\xE5\xAD\xA9\x22,\x22field_5\x22:[\x22\xE4\xBC\x9A\xE9\x95\xBF\xE9\x9A\xBE\xE7\x9C\x8B\xE7\x9A\x84\xE5\xA6\x8A\xE5\xA8\xA0\xE7\xBA\xB9\x22,\x22\xE6\x80\x80\xE5\xAD\x95\xE5\x90\x8E\xE4\xB8\x8D\xE6\x95\xA2\xE7\x94\xA8\xE6\x8A\xA4\xE8\x82\xA4\xE5\x93\x81\xEF\xBC\x8C\xE7\x9A\xAE\xE8\x82\xA4\xE5\x8F\x98\xE5\xB7\xAE\x22,\x22\xE6\x80\x80\xE5\xAD\x95\xE6\x97\xB6\xE5\x80\x99\xE5\xBE\x88\xE9\x9A\xBE\xE5\x8F\x97\xEF\xBC\x8C\xE7\xBB\x8F\xE5\xB8\xB8\xE5\xAD\x95\xE5\x90\x90\x22],\x22field_6\x22:\x22\xE5\x9C\xA8\xE5\xAE\xB6\xE9\x87\x8C\xE8\xAE\xA9\xE7\x88\xB6\xE6\xAF\x8D\xE3\x80\x81\xE8\x80\x81\xE5\x85\xAC\xE7\x85\xA7\xE9\xA1\xBE\xE8\x87\xAA\xE5\xB7\xB1\xE5\x81\x9A\xE6\x9C\x88\xE5\xAD\x90\x22,\x22field_7\x22:\x22\xE5\xA5\xB6\xE7\xB2\x89\xE5\x96\x82\xE5\x85\xBB\x22,\x22field_8\x22:\x22\xE5\x93\xBA\xE4\xB9\xB3\xE6\x9C\x9F\xE5\x90\x8E\xEF\xBC\x8C\xE4\xBA\xA4\xE7\xBB\x99\xE7\x88\xB6\xE6\xAF\x8D\xE5\xB8\xA6\xE5\xAD\xA9\xE5\xAD\x90\xEF\xBC\x8C\xE8\x87\xAA\xE5\xB7\xB1\xE4\xB8\x8A\xE7\x8F\xAD\x22,\x22field_9\x22:\x2210\xE4\xB8\x87~20\xE4\xB8\x87\x22,\x22creator_name\x22:\x22dreamlinx\x22,\x22created_at\x22:\x222016-11-15T18:00:59.915Z\x22,\x22updated_at\x22:\x222016-11-15T18:00:59.915Z\x22,\x22info_remote_ip\x22:\x22124.79.191.47\x22}}"
# params = JSON.parse raw
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

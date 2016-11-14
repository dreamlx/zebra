class Api::EventsController < Api::BaseController

  def record
    if params[:entry]
      Event.find_or_create_by(from: params[:form],
                              from_name: params[:form_name],
                              serial_number: params[:entry][:serial_number],
                              field_1: params[:entry][:field_1],
                              field_2: params[:entry][:field_2],
                              field_8: params[:entry][:field_8],
                              field_9: params[:entry][:field_9],
                              field_15: params[:entry][:field_15],
                              gen_code: params[:entry][:gen_code],
                              field_9: params[:entry][:field_9])
      render json: {}, status: 200
    else
      return api_error(status: 401)
    end
  end
end

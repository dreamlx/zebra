class Api::BaseController < ApplicationController
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable cookies (no set-cookies header in response)
  before_action :destroy_session
  skip_before_action :logged_in_admin

  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  attr_accessor :current_user

  private
    def authenticate_user!
      open_id = ActionController::HttpAuthentication::Token.token_and_options(request)
      user = User.find_by(openid: open_id)
      if user
        self.current_user = user
      else
        return unauthenticated!
      end
    end

    def unauthenticated!
      api_error(status: 401)
    end
end

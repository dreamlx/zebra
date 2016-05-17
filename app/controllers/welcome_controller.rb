class WelcomeController < ApplicationController
  def index
  	render layout: "login"
  end
end
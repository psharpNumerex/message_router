class MessagesController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: Rails.application.secrets.basic_auth_name, password: Rails.application.secrets.basic_auth_password


  def push_to_amq
    message = params[:message]
    head :ok
  end

end

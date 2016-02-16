class MessagesController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: Rails.application.secrets.basic_auth_name, password: Rails.application.secrets.basic_auth_password


  def push_to_amq
    message = params[:message].to_json
    Rails.logger.info "#{Time.now.to_s(:db)} - message - #{message}"
    Pusher.push(message)
    head :ok
  rescue
    Rails.logger.info $!
    $@.each{|line| Rails.logger.info line}
    head :internal_server_error
  end

end

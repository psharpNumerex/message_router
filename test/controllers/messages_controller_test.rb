require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  context 'authentication' do
    should 'not allow entry' do
      post '/messages'
      assert_response :unauthorized
    end

    should 'allow entry' do
      auth_header = { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Rails.application.secrets.basic_auth_name, Rails.application.secrets.basic_auth_password) }
      post '/messages', headers: auth_header
      assert_response :success
    end
  end

end

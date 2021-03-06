require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  context 'push to amq' do
    should 'not allow entry' do
      post '/messages'
      assert_response :unauthorized
    end

    should 'allow entry' do
      auth_header = { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Rails.application.secrets.basic_auth_name, Rails.application.secrets.basic_auth_password) }
      Pusher.expects(:push).with({device_name: "012606000242461",device_name_type:"imei"}.to_json)
      post '/messages', params: {message: {device_name: "012606000242461",device_name_type:"imei"}}, headers: auth_header
      assert_response :success
    end

    should 'respond with a 500' do
      auth_header = { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(Rails.application.secrets.basic_auth_name, Rails.application.secrets.basic_auth_password) }
      Pusher.expects(:push).raises('ERROR')
      post '/messages', params: {message: 'this is a message'}, headers: auth_header
      assert_response :error
    end
  end

end

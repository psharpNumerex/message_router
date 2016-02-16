require 'test_helper'

class PusherTest < ActiveSupport::TestCase

  context 'client' do
    setup do
      Pusher.reset
    end

    should 'create and reuse new stomp client' do
      Stomp::Client.expects(:new).returns(OpenStruct.new(:open? => true))
      assert Pusher.client

      Stomp::Client.expects(:new).never
      assert Pusher.client
    end

    should 'request new client if current client closes' do
      Stomp::Client.expects(:new).returns(OpenStruct.new(:open? => false))
      assert Pusher.client

      Stomp::Client.expects(:new).returns(OpenStruct.new(:open? => true))
      assert Pusher.client
    end
  end

  context 'push' do
    setup do
      Pusher.reset
    end

    should 'send the message to amq' do
      stomp_client = OpenStruct.new(:open? => true)
      Stomp::Client.expects(:new).returns(stomp_client)
      stomp_client.expects(:publish).with(Rails.application.secrets.stomp_endpoint, 'message', {persistent: true})

      Pusher.push('message')
    end
  end

end
class Pusher
  class << self
    def push(message)
      client.publish(Rails.application.secrets.stomp_endpoint, message)
    end
    
    def client
      @@client ||= Stomp::Client.new(:hosts => [connection_hash], :max_reconnect_attempts => 1)
    end
    
    def connection_hash
      Rails.application.secrets.stomp_connection.with_indifferent_access
    end
  end
end
class Pusher
  @@client = nil
  
  class << self
    def reset
      @@client = nil
    end

    def push(message)
      client.publish(Rails.application.secrets.stomp_endpoint, message, {persistent: true})
    end
    
    def client
      return @@client if @@client.try(:open?)
      @@client = Stomp::Client.new(:hosts => [connection_hash], :max_reconnect_attempts => 1)
    end
    
    def connection_hash
      Rails.application.secrets.stomp_connection.with_indifferent_access
    end
  end
end
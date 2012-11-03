module Shared
  module Channels

    def channels(channels)
      subscriptions = {}
      channels.each do |channel|
        subscriptions[channel] = sign_channel(channel)
      end
      subscriptions
    end

    def sign_channel(channel)
      secret = "55597e88836406ce96973b97546411be6fa12ebffc8c5d62980b4ef0cd45"
      time = (Time.now.to_f * 1000).round
      {
        timestamp: time,
        signature: Digest::SHA1.hexdigest([secret, channel, time].join)
      }
    end
  end
end
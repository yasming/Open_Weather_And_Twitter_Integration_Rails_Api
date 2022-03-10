class TwitterIntegration

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
    end
  end

  def comment(comment)
    begin
      @client.update(comment)
    rescue => e
      false
    end
  end
end
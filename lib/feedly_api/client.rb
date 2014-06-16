require 'feedly_api/api'

module FeedlyApi
  class Client
    include API

    attr_reader :auth_token

    def initialize(access_token=nil)
      @access_token = access_token
    end

    def user_id
      get_user_profile[:id]
    end

    def feed(feed_id)
      Feed.new(self, feed_id)
    end

    private

    def make_request(path, argv = {})
      url = FeedlyApi::API_ENDPOINT + path + '?'

      argv.each do |k, v|
        url << "#{k}=#{v}&"
      end

      JSON.parse(FeedlyApi.get(url, @access_token), symbolize_names: true)
    end
  end
end

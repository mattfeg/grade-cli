require "faraday"

module Grade
  class ApiClient
    API_CLIENT_BASE_URL = ENV.fetch("API_CLIENT_BASE_URL")

    def initialize(api_key:)
      @conn = Faraday.new(url: API_CLIENT_BASE_URL) do |f|
        f.request   :json
        f.response  :json
        f.response  :raise_error
        f.adapter   Faraday.default_adapter
      end
      @api_key = api_key
    end

    def get(path, params = {})
      @conn.get(path, params) { |req| authorize(req) }.body
    end

    private

    def authorize(req)
      req.headers["Authorization"] = "Bearer #{@api_key}"
    end
  end
end

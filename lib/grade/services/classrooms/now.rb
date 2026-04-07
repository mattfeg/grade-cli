module Grade
  module Services
    module Classrooms
      class Now < BaseService
        def initialize(client:)
          @client = client
        end

        def call
          data = @client.get("classrooms/now")
          success(data)
        rescue Faraday::UnauthorizedError
          failure("Invalid API key.")
        rescue Faraday::ConnectionFailed
          failure("No connection to the API.")
        end
      end
    end
  end
end

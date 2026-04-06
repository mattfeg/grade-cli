module Grade
  module Services
    module Classrooms
      class List < BaseService
        def initialize(client:)
          @client = client
        end

        def call
         data = @client.get("classrooms")
         sucess(data) 
        rescue Faraday::UnauthorizedError
         failure("Invalid API key.")
        rescue Faraday::ConnectionFailed
         failure("No connection to the API.")
        end
      end
    end
  end
end

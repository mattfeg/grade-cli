module Grade
  module Services
    module Auth
      class Login < BaseService
        def initialize(client:, email:, password:)
          @client   = client
          @email    = email
          @password = password
        end

        def call
          result = @client.post("/users/sign_in", { user: { email: @email, password: @password } })
          token = result[:headers]["authorization"]&.sub("Bearer ", "")
          return failure("Invalid credentials") unless token
          success(token)
        rescue Faraday::UnauthorizedError
          failure("Invalid credentials")
        rescue Faraday::ConnectionFailed
          failure("Could not connect to the server")
        end
      end
    end
  end
end

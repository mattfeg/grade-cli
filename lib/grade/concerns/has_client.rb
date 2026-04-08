# frozen_string_literal: true

module Grade
  module Concerns
    module HasClient
      include HasKeychain

      private

      def client
        token = read_token
        unless token
          say 'Not authenticated. Run `grade auth login`', :red
          exit 1
        end
        @client ||= ApiClient.new(api_key: token)
      end
    end
  end
end

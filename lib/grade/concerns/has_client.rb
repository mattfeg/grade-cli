module Grade
  module Concerns
    module HasClient
      private
      def client
        key = "changeme"
        @client ||= ApiClient.new(api_key: key)
      end  
    end
  end
end


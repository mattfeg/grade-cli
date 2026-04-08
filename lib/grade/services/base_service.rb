# frozen_string_literal: true

module Grade
  module Services
    class BaseService
      def self.call(...)
        new(...).call
      end

      private

      def success(data)
        { ok: true, data: data }
      end

      def failure(message)
        { ok: false, error: message }
      end
    end
  end
end

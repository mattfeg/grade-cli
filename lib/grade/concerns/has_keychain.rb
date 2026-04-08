# frozen_string_literal: true

module Grade
  module Concerns
    module HasKeychain
      KEYCHAIN_SERVICE = 'grade-cli'
      KEYCHAIN_ACCOUNT = 'jwt_token'

      private

      def save_token(token)
        delete_token
        Keychain.generic_passwords.create(
          service: KEYCHAIN_SERVICE,
          account: KEYCHAIN_ACCOUNT,
          password: token
        )
      end

      def read_token
        item = Keychain.generic_passwords
                       .where(service: KEYCHAIN_SERVICE, account: KEYCHAIN_ACCOUNT)
                       .first
        item&.password
      end

      def delete_token
        item = Keychain.generic_passwords
                       .where(service: KEYCHAIN_SERVICE, account: KEYCHAIN_ACCOUNT)
                       .first
        item&.delete
      end
    end
  end
end

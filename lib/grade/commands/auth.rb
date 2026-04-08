module Grade
  module Commands
    class Auth < Thor
      include Concerns::HasKeychain

      desc "login", "Authenticate with your credentials"
      def login
        email    = ask("Email:")
        password = ask("Password:", echo: false)
        say ""

        spinner = TTY::Spinner.new("[:spinner] Authenticating...", format: :dots)
        spinner.auto_spin

        result = Services::Auth::Login.call(client: ApiClient.new, email: email, password: password)

        if result[:ok]
          save_token(result[:data])
          spinner.success(Pastel.new.green("Logged in!"))
        else
          spinner.error("Error!")
          say result[:error], :red
          exit 1
        end
      end

      desc "logout", "Remove stored credentials"
      def logout
        delete_token
        say Pastel.new.green("Logged out.")
      end
    end
  end
end

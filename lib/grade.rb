require "thor"
require "dotenv/load"
require_relative "grade/version"
require_relative "grade/ApiClient"
require_relative "grade/services/base_service"
require_relative "grade/services/classrooms/list"

module Grade
  class CLI < Thor
    package_name "Grade"

    desc "version", "Shows software version"
    map ["--version","-v"] => :version
    def version
      puts "Grade V#{Grade::VERSION}"
    end

    desc "list", "List all Classrooms"
    def list
      result = Services::Classrooms::List.call(client: client)

      if result[:ok]
        result[:data].each { |item| say "- #{item["name"]}"  }
      else
        say result[:error], :red
        exit 1
      end
    end

    private 

    def client
      key = "changeme"
      @client ||= ApiClient.new(api_key: key)
    end
  end 
end


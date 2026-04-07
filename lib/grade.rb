require "thor"
require "dotenv/load"
require "tty-spinner"
require "tty-table"
require "pastel"
require_relative "grade/version"
require_relative "grade/ApiClient"
require_relative "grade/services/base_service"
require_relative "grade/services/classrooms/list"
require_relative "grade/concerns/has_client"
require_relative "grade/commands/classrooms"

module Grade
  class CLI < Thor
    package_name "Grade"
    
    desc "classrooms SUBCOMMAND", "Manage classrooms"
    subcommand "classrooms", Commands::Classrooms

    desc "version", "Shows software version"
    map ["--version","-v"] => :version
    def version
      say "Grade V#{Grade::VERSION}"
    end
  end 
end


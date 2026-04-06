require "thor"
require_relative "grade/version"

module Grade
  class CLI < Thor
    package_name "Grade"

    desc "version", "Shows software version"
    map ["--version","-v"] => :version
    def version
      puts "Grade V#{Grade::VERSION}"
    end
  end 
end


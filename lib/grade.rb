require "thor"
require "dotenv/load"
require "tty-spinner"
require "tty-table"
require "pastel"
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
      say "Grade V#{Grade::VERSION}"
    end

    desc "list", "List all Classrooms"
    def list
      pastel = Pastel.new
      spinner = TTY::Spinner.new("[:spinner] Searching...", format: :dots)
      spinner.auto_spin
      sleep(1.5)

      result = Services::Classrooms::List.call(client: client)

      if result[:ok]
        spinner.success(pastel.green("Done!"))
        time_slot_now = "tab"

        table = TTY::Table.new(header: ["Class code", "Class name", "Room", "Time slot"])
        result[:data].each do |item|
          time_slot_formatted = item["time_slot"]==time_slot_now ? pastel.yellow(item["time_slot"].upcase) : item["time_slot"].upcase
          table << [item["cod"], item["name"], item["room"], time_slot_formatted]
        end

        say table.render(:unicode, alignments: [:center, :left, :center, :center])
      else
        spinner.error("Error!")
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


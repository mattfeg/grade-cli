module Grade
  module Commands
    class Classrooms < Thor
      include Concerns::HasClient

      desc "list", "List all Classrooms"
      def list
        pastel = Pastel.new
        spinner = TTY::Spinner.new("[:spinner] Searching...", format: :dots)
        spinner.auto_spin
        sleep(1)

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
    end 
  end
end

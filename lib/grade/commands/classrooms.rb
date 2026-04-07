module Grade
  module Commands
    class Classrooms < Thor
      include Concerns::HasClient

      desc "list", "List all Classrooms"
      def list
        pastel = Pastel.new
        
        loading_search
        result = Services::Classrooms::List.call(client: client)

        if result[:ok]
          @spinner.success(pastel.green("Done!"))

          table = TTY::Table.new(header: ["Class code", "Class name", "Room", "Time slot"])
          result[:data].each do |item| 
            table << [item["cod"], item["name"], item["room"], item["time_slot"].upcase]
          end

          say table.render(:unicode, alignments: [:center, :left, :center, :center])
        else
          @spinner.error("Error!")
          say result[:error], :red
          exit 1
        end
      end

      desc "now", "Show the actual class info"
      def now
        pastel = Pastel.new

        loading_search
        result = Services::Classrooms::Now.call(client: client)

        if result[:ok]
          @spinner.success(pastel.green("Done!"))
          
          table = TTY::Table.new(header: ["Class code", "Class name", "Room", "Time slot"])
          result[:data].each do |item|
            table << [item["cod"], item["name"], item["room"].upcase, item["time_slot"].upcase]
          end

           say table.render(:unicode, alignments: [:center, :left, :center, :center])
        else
          @spinner.error("Error!")
          say result[:error], :red
          exit 1
        end
      end

      private

      def loading_search
        @spinner = TTY::Spinner.new("[:spinner] Searching...", format: :dots)
        @spinner.auto_spin
        sleep(1)
      end
    end 
  end
end

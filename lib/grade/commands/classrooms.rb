module Grade
  module Commands
    class Classrooms < Thor
      include Concerns::HasClient

      desc "list", "List all Classrooms"
      def list
        loading_search
        handle_result(result: Services::Classrooms::List.call(client: client))
      end

      desc "now", "Show the actual class info"
      def now
        loading_search
        handle_result(result: Services::Classrooms::Now.call(client: client))
      end

      private

      def loading_search
        @spinner = TTY::Spinner.new("[:spinner] Searching...", format: :dots)
        @spinner.auto_spin
        sleep(1)
      end

      def format_table(result:)
        table = TTY::Table.new(header: ["Class code", "Class name", "Room", "Time slot"])
          result[:data].each do |item| 
            table << [item["cod"], item["name"], item["room"], item["time_slot"].upcase]
          end
        table
      end

      def pastel
        @pastel ||= Pastel.new
      end

      def handle_result(result:)
        if result[:ok]
          @spinner.success(pastel.green("Done!"))
          say format_table(result: result).render(:unicode, alignments: [:center, :left, :center, :center])
        else
          @spinner.error("Error!")
          say result[:error], :red
          exit 1
        end
      end
    end 
  end
end

# frozen_string_literal: true

module CryptoNestEgg
  ##
  # Create a CSV file that holds results
  class CSVFile
    def initialize(file_path)
      @csv_file = file_path
    end

    def save_to_csv(results)
      CSV.open(@csv_file, 'w') do |writer|
        results.each do |cc|
          writer << [cc.name, cc.price, cc.market_cap]
        end
      end
    end
  end
end

# frozen_string_literal: true

module CryptoNestEgg
  ##
  # Main class of the project. Call the main class to start using this project.
  class Runner
    def initialize
      @config = ConfigFile.new(CONFIG_DEFAULT)
      @api = CoingeckoAPI.new
    end

    def run
      download_informations
      save_to_csv
    end

    private

    attr_reader :api

    def download_informations
      api.download(@config)
    end

    def save_to_csv
      csv_file = DATA_FOLDER.join('cc_results.csv').freeze

      CSV.open(csv_file, 'w') do |writer|
        api.results.each do |cc|
          writer << [cc.name, cc.price, cc.market_cap]
        end
      end
    end
  end
end

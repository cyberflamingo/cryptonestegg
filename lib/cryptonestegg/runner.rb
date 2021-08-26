# frozen_string_literal: true

module CryptoNestEgg
  ##
  # Main class of the project. Call the main class to start using this project.
  class Runner
    def initialize
      @config = ConfigFile.new(CONFIG_DEFAULT)
      @api = CoingeckoAPI.new
      @results_file = CSVFile.new(RESULTS_FILE)
    end

    def run
      download_informations
      @results_file.save_to_csv(api.results)
    end

    private

    attr_reader :api

    def download_informations
      api.download(@config)
    end
  end
end

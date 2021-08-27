# frozen_string_literal: true

module CryptoNestEgg
  ##
  # Main class of the project. Call the main class to start using this project.
  class Runner
    def initialize
      @config = ConfigFile.new(CONFIG_DEFAULT)
      @client = API.select(PROVIDER)
      @results_file = CSVFile.new(RESULTS_FILE)
    end

    def run
      client.check_connection
      client.fetch_prices(@config)
      @results_file.save_to_csv(client.response)
    end

    private

    attr_reader :client
  end
end

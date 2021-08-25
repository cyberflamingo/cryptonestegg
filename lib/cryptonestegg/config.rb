# frozen_string_literal: true

require 'tomlrb'

module CryptoNestEgg
  ##
  # Loads the config file with a list of currency and the portfolio.
  class ConfigFile
    attr_reader :currency, :portfolio

    def initialize(config_file)
      @config = load(config_file)
      @currency = @config[:currency].nil? ? 'USD' : @config[:currency]

      @portfolio = @config[:portfolio]
    end

    private

    def load(config_file)
      config = Tomlrb.load_file(config_file, symbolize_keys: true)

      raise ArgumentError, 'Config file is empty' if config.empty?

      portfolio = config[:portfolio]

      if portfolio.nil? || portfolio.empty?
        raise ArgumentError, 'Config file has no portfolio or is empty'
      end

      config
    end
  end
end

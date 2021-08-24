# frozen_string_literal: true

require 'tomlrb'

module CryptoNestEgg
  ##
  # Loads the config file with a list of currency and the portfolio.
  class ConfigFile
    attr_reader :currency, :portfolio

    def initialize(config_file)
      @config = load(config_file)
      @currency = @config[:currency]
      @portfolio = @config[:portfolio]
    end
  end
end

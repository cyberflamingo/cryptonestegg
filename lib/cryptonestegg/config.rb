require 'tomlrb'

##
# Loads the config file with a list of currency and the portfolio.
class ConfigFile
  attr_reader :currency, :portfolio

  def initialize
    @config = Tomlrb.load_file(CONFIG_DEFAULT, symbolize_keys: true)
    @currency = @config[:currency]
    @portfolio = @config[:portfolio]
  end
end

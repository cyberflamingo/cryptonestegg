require 'curb'
require 'csv'
require 'json'
require 'tomlrb'
require 'uri'
require 'yaml'

class ConfigFile
  attr_reader :currency, :portfolio

  def initialize
    @config = Tomlrb.load_file('config.toml', symbolize_keys: true)
    @currency = @config[:currency]
    @portfolio = @config[:portfolio]
  end
end

class CoingeckoAPI
  attr_reader :results

  def initialize
    @base_uri = 'https://api.coingecko.com/api/v3' + '/simple/price'
    @ids = []
    @vs_currency = 'USD'
    @include_market_cap = true
    # @include_last_updated_at = true
    @results = []
  end

  def download(settings)
    self.ids = format_portfolio(settings.portfolio.keys)
    self.vs_currency = settings.currency

    ids.each do |id|
      body_res = get_price(id)
      unless body_res == '{}'
        results << format_response(JSON.parse(body_res))
      end
    end
  end

  private

  attr_reader :base_uri
  attr_accessor :ids, :vs_currency, :include_market_cap

  def format_portfolio(ids)
    ids.map do |id|
      id.to_s.gsub(' ', '')
    end
  end

  def get_price(id)
    uri = "#{base_uri}?ids=#{id}" \
          "&vs_currencies=#{vs_currency}" \
          "&include_market_cap=#{include_market_cap}"

    sleep(1)
    http = Curl.get(uri) do |req|
      req.headers['accept'] = 'application/json'
    end

    http.body_str
  end

  def format_response(json)
    currency   = vs_currency.downcase
    name       = json.keys[0]
    price      = json[name][currency]
    market_cap = json[name]["#{currency}_market_cap"]

    Cryptocurrency.new(name, price, market_cap)
  end
end

class Cryptocurrency
  attr_reader :name, :price, :market_cap

  def initialize(name, price, market_cap)
    @name = name
    @price = price
    @market_cap = market_cap
  end
end

class CoinDownloader
  def main
    read_config_file
    download_informations
    save_to_csv
  end

  private

  attr_reader :config, :api

  def read_config_file
    @config = ConfigFile.new
  end

  def download_informations
    @api = CoingeckoAPI.new
    @api.download(config)
  end

  def save_to_csv
    csv_file = 'cc_results.csv'

    CSV.open(csv_file, 'w') do |writer|
      api.results.each do |cc|
        writer << [cc.name, cc.price, cc.market_cap]
      end
    end
  end
end

download = CoinDownloader.new
download.main

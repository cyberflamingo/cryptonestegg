# frozen_string_literal: true

require 'json'
require 'net/http'

module CryptoNestEgg
  ##
  # Calls the CoinGecko API and format the result.
  class CoinGeckoAPI
    attr_reader :results

    def initialize
      @base_uri = URI('https://api.coingecko.com/api/v3/simple/price')
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
        results << format_response(JSON.parse(body_res)) unless body_res == '{}'
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
      params = { ids: id, vs_currencies: vs_currency,
                 include_market_cap: include_market_cap }
      base_uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(base_uri)

      if res.is_a?(Net::HTTPSuccess)
        res.body
      else
        # TODO: Handle unsuccessful Net::HTTPResponse
        ''
      end
    end

    def format_response(json)
      currency   = vs_currency.downcase
      name       = json.keys[0]
      price      = json[name][currency]
      market_cap = json[name]["#{currency}_market_cap"]

      Cryptocurrency.new(name.to_sym, price, market_cap)
    end
  end
end

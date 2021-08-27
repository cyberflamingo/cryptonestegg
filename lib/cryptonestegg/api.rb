# frozen_string_literal: true

require 'coingecko_ruby'

module CryptoNestEgg
  # Instantiate an API client. Use the create method to select the provider.
  class API
    ##
    # Select which API provider to use. For the time being, Coingecko is the
    # only available provider.
    def self.select(_provider)
      CoinGeckoAPI.new
    end
  end

  ##
  # Calls the CoinGecko API and format the result.
  class CoinGeckoAPI
    attr_reader :response

    def initialize
      @client = CoingeckoRuby::Client.new
      @response = {}
    end

    def check_connection # rubocop:disable Metrics/MethodLength
      puts "Checking #{PROVIDER}'s status..."

      begin
        attempts ||= 0

        raise Timeout::Error unless ping
      rescue Timeout::Error
        attempts += 1

        puts "Waiting #{RETRY_TIME} seconds and retring... " \
        "(#{attempts}/#{RETRY_LIMIT})"

        sleep(RETRY_TIME)

        retry if attempts < RETRY_LIMIT

        puts 'Connection failed. Exiting.'
        exit
      end
    end

    def fetch_prices(conf)
      json = client.prices(conf.portfolio.keys,
                           currency: conf.currency,
                           include_market_cap: true,
                           include_24hr_vol: false,
                           include_24hr_change: false,
                           include_last_updated_at: false)

      @response = format(json, conf.currency)
    end

    private

    attr_reader :client

    def ping
      client.status['gecko_says'] == '(V3) To the Moon!'
    end

    def format(res, currency)
      res.map do |key, value|
        Cryptocurrency.new(key.to_sym,
                           value[currency],
                           value["#{currency}_market_cap"])
      end
    end
  end
end

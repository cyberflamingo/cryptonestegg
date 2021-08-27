# frozen_string_literal: true

require_relative 'test_helper'

class CoinGeckoAPITest < Minitest::Test
  def setup
    toml = PROJECT_ROOT.join('test/config_tests')
                       .join('config_simple.toml').freeze
    @config = ConfigFile.new(toml)
    @portfolio = @config.portfolio.keys.map(&:downcase)

    @api = CoinGeckoAPI.new
  end

  def test_api_initialized_with_empty_state
    assert_empty(@api.response)
  end

  def test_fetch_prices_from_api
    skip
    # TODO: Mockup the API's response so that the test is not dependent on
    # network latency
    @api.fetch_prices(@config)

    coins = @api.response

    assert_equal(2, coins.size)
    assert_equal(@portfolio.sort, coins.map(&:name).sort)
    assert(coins.map(&:price).all? { |price| price.instance_of?(Float) })
    assert(coins.map(&:market_cap).all? { |cap| cap.instance_of?(Float) })
  end
end

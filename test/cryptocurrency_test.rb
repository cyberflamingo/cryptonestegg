# frozen_string_literal: true

require_relative 'test_helper'

class CryptocurrencyTest < Minitest::Test
  def setup
    @name = 'yieldly'
    @price = 0.0238131
    @market_cap = 51_598_947.69799517

    @coin = Cryptocurrency.new(@name, @price, @market_cap)
  end

  def test_coin_attr_reader_availability
    assert_equal(@name, @coin.name)
    assert_equal(@price, @coin.price)
    assert_equal(@market_cap, @coin.market_cap)
  end

  def test_coin_attr_writter_unavailability
    assert_raises(NoMethodError) { @coin.name = 'algorand' }
    assert_raises(NoMethodError) { @coin.price = 1.04 }
    assert_raises(NoMethodError) { @coin.market_cap = 3_567_282_711.185636 }
  end
end

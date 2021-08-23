##
# Cryptocurrency objects represent one cryptocurrency's name, price and market
# capitalization
class Cryptocurrency
  attr_reader :name, :price, :market_cap

  def initialize(name, price, market_cap)
    @name = name
    @price = price
    @market_cap = market_cap
  end
end

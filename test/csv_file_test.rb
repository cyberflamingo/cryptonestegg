# frozen_string_literal: true

require_relative 'test_helper'
require 'pry'

class CSVFileTest < Minitest::Test
  def setup
    result_tests_folder = PROJECT_ROOT.join('test/result_tests').freeze
    @results_csv = result_tests_folder.join('result_simple.csv').freeze
    @csv = CSVFile.new(@results_csv)

    @data = [Cryptocurrency.new('ethereum', 352_311,
                                41_340_367_842_106.6),
             Cryptocurrency.new('algorand', 115.99, 399_564_228_107.347),
             Cryptocurrency.new('yieldly', 2.66, 5_766_344_878.4488)]
  end

  def test_can_save_to_csv
    # binding.pry
    @csv.save_to_csv(@data)

    assert_equal(csvify(@data), CSV.read(@results_csv))
  end

  def test_overwrite_saved_file
    test_can_save_to_csv

    data = [Cryptocurrency.new('tezos', 471.34, 397_511_781_736.4441),
            Cryptocurrency.new('cosmos', 2219.57, 616_895_192_962.1523)]

    @csv.save_to_csv(data)

    assert_equal(csvify(data), CSV.read(@results_csv))
  end

  private

  def csvify(data)
    data.map do |coin|
      [(coin.name).to_s, (coin.price).to_s, (coin.market_cap).to_s]
    end
  end
end

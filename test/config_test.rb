# frozen_string_literal: true

require_relative 'test_helper'

class ConfigFileTest < Minitest::Test
  def setup
    @config_tests_folder = PROJECT_ROOT.join('test/config_tests').freeze
    @currency = 'eur'
    @portfolio = { Monero: 0, Algorand: 0 }
  end

  class LoadTest < ConfigFileTest
    def test_read_simple_toml_file
      toml = @config_tests_folder.join('config_simple.toml').freeze
      config = ConfigFile.new(toml)

      assert_instance_of(ConfigFile, config)
      assert_equal(@currency, config.currency)
      assert_equal(@portfolio, config.portfolio)
    end

    def test_read_no_file
      assert_raises(Errno::ENOENT, 'No such file or directory') do
        ConfigFile.new('')
      end
    end

    def test_read_empty_toml_file
      toml = @config_tests_folder.join('config_empty.toml').freeze

      assert_raises(ArgumentError, 'Config file is empty') do
        ConfigFile.new(toml)
      end
    end

    def test_read_no_portfolio_toml_file
      toml = @config_tests_folder.join('config_no_portfolio.toml').freeze

      assert_raises(ArgumentError,
                    'Config file has no portfolio or is empty') do
        ConfigFile.new(toml)
      end
    end

    def test_read_empty_portfolio_toml_file
      toml = @config_tests_folder.join('config_empty_portfolio.toml').freeze

      assert_raises(ArgumentError,
                    'Config file has no portfolio or is empty') do
        ConfigFile.new(toml)
      end
    end

    def test_read_broken_toml_file
      toml = @config_tests_folder.join('config_broken.toml').freeze

      assert_raises(Tomlrb::ParseError, 'Unclosed table') do
        ConfigFile.new(toml)
      end
    end

    def test_read_yaml_file
      yaml = @config_tests_folder.join('config_simple.yaml').freeze

      assert_raises(Tomlrb::ParseError) do
        ConfigFile.new(yaml)
      end
    end

    def test_read_txt_file_with_toml_syntax
      txt = @config_tests_folder.join('config_simple.txt').freeze
      config = ConfigFile.new(txt)

      assert_instance_of(ConfigFile, config)
      assert_equal(@currency, config.currency)
      assert_equal(@portfolio, config.portfolio)
    end
  end

  class Parse < ConfigFileTest
    def test_parsed_file_has_symbolize_keys
      toml = @config_tests_folder.join('config_simple.toml').freeze
      config = ConfigFile.new(toml)

      assert(config.portfolio.keys.all? { |key| key.instance_of?(Symbol) })
    end

    def test_default_currency_is_usd
      toml = @config_tests_folder.join('config_no_currency.toml').freeze
      config = ConfigFile.new(toml)

      assert_empty(toml.read.scan('currency'))
      assert_equal('usd', config.currency)
    end
  end
end

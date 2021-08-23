# frozen_string_literal: true

require 'bundler/setup'
require 'csv'
require 'pathname'

require_relative 'cryptonestegg/api'
require_relative 'cryptonestegg/config'
require_relative 'cryptonestegg/cryptocurrency'
require_relative 'cryptonestegg/version'

PROJECT_ROOT   = Pathname.new(__dir__).parent.expand_path.freeze
DATA_FOLDER    = PROJECT_ROOT.join('data').freeze
CONFIG_DEFAULT = DATA_FOLDER.join('config.toml').freeze

##
# Main class of the project. Call the main class to start using this project.
class CryptoNestEgg
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
    csv_file = DATA_FOLDER.join('cc_results.csv').freeze

    CSV.open(csv_file, 'w') do |writer|
      api.results.each do |cc|
        writer << [cc.name, cc.price, cc.market_cap]
      end
    end
  end
end

download = CryptoNestEgg.new
download.main

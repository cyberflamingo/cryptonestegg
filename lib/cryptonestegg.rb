# frozen_string_literal: true

require 'bundler/setup'
require 'csv'
require 'pathname'

require_relative 'cryptonestegg/api'
require_relative 'cryptonestegg/config'
require_relative 'cryptonestegg/cryptocurrency'
require_relative 'cryptonestegg/csv_file'
require_relative 'cryptonestegg/runner'
require_relative 'cryptonestegg/version'

PROJECT_ROOT   = Pathname.new(__dir__).parent.expand_path.freeze
DATA_FOLDER    = PROJECT_ROOT.join('data').freeze
CONFIG_DEFAULT = DATA_FOLDER.join('config.toml').freeze
RESULTS_FILE   = DATA_FOLDER.join('cc_results.csv').freeze

PROVIDER       = 'CoinGecko'
RETRY_LIMIT    = 5
RETRY_TIME     = 60 # seconds

runner = CryptoNestEgg::Runner.new
runner.run

# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'cryptonestegg'

require 'minitest/autorun'

# Include module so we don't need to write `CryptoNestEgg::MyClass` each time
include CryptoNestEgg

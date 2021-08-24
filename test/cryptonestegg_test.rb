# frozen_string_literal: true

require 'bundler/setup'
require 'minitest/autorun'
require 'test_helper'

class CryptoNestEggTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil VERSION
  end
end

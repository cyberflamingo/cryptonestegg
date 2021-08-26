# frozen_string_literal: true

require_relative 'lib/cryptonestegg/version'

Gem::Specification.new do |spec|
  spec.name          = 'CryptoNestEgg'
  spec.version       = CryptoNestEgg::VERSION
  spec.license       = 'Apache-2.0'
  spec.authors       = ['Alexandre Mercier']
  spec.email         = ['alex@cyberflamingo.net']
  spec.homepage      = 'https://github.com/cyberflamingo/cryptonestegg'

  spec.summary       = 'Build Your Nest Egg with CryptoCurrency'
  spec.description   = <<-DESCRIPTION
    CryptoNestEgg is a simple script to download current price and market cap
    for a list of cryptocurrency. The script reads from a `config.toml` file and
    returns the result in a `csv` file.
  DESCRIPTION
  spec.required_ruby_version = '>= 2.7'

  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/cyberflamingo/cryptonestegg/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{\A(?:test|spec|features)/})
    end
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('tomlrb', '~> 2.0')
end

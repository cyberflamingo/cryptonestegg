# Changelog

## [0.4.0] - 2021-08-29

- Use CoinGecko recommanded Ruby's API
  https://www.coingecko.com/en/api/documentation#accordion
- Fix tests accordingly

## [0.3.0] - 2021-08-26

- Add tests for each program files
- Pass config files and constants as parameters
- Symbolize cryptocoin's name
- Separate CSV related program in new class

## [0.2.2] - 2021-08-24

- Reorganize code and split by class
- Encircle code inside module & create Runner class
- Downgrade Rubocop to 0.86.0
  - Update `.rubocop.yml`

## [0.2.1] - 2021-08-05

- Add rdoc to main Ruby file
- Separate runtime and development dependencies respectivly in`.gemspec`
  and `Gemfile`

## [0.2.0] - 2021-08-04

- Use Bundler
- Reorganize to adhere to Ruby projects' organization
- User Bundler's default `test` and `lib` folder and files
- Add `gemspec`
- Add `Rakefile`
- Add `.rubocop.yml`
- Add `CHANGELOG.md`

## [0.1.0] - 2021-07-07

- Initial release

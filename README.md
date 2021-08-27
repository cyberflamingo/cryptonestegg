# CryptoNestEgg

> Build Your Nest Egg with CryptoCurrency

CryptoNestEgg is a simple script to download current price and market cap
for a list of cryptocurrency. The script reads from a `config.toml` file
and returns the result in a `csv` file.

## Getting Started

First, make sure you have Ruby and Bundle installed on your system (not
covered here).

Download or clone this repository and run `bundle install` inside it.

```sh
git clone https://github.com/cyberflamingo/cryptonestegg
cd cryptonestegg/
bundle install
```

### Initial Configuration

Copy the template config file to a new config file, open it and populate it
with cryptocurrencies of your liking.

```sh
cp config.toml.tmpl config.toml
```

## Features

- Easily download your favorite cryptocurrencies' price and market
  capitalization.
- That's all for now.

## Configuration

The following options can be set in your `config.toml` file.

### Currency

Set the currency to use.

```toml
currency = "JPY"
```

### Portfolio

Set the name of the cryptocurrencies you want to follow. The name of each
coin should be the one used by CoinGecko API V3. Refer to the
[documentation](https://www.coingecko.com/api/documentations/v3) for each
coin's name.

```toml
[portfolio]
  Monero = 0
  Stellar = 0
  Algorand = 0
  Tezos = 0
```

## Improvement

- Add support for APIs other than CoinGecko.
- Cryptocurrency names/symboles are from CoinGecko's API which naming is
  sometimes confusing. A list of commons name for a cryptocurrency could be
  useful in the future.
- Error handling.
- Use parameters/make it possible to write it in the config file.

## Licensing

The code in this project is licensed under [Apache License 2.0](./LICENSE).

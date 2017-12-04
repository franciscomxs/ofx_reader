# OFXReader

Simple OFX Reader

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ofx_reader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ofx_reader

## Usage

```ruby
ofx = OFXReader::Parser::OFX102.new(ofx_text)
```

#### Headers

```ruby
ofx.headers
=> {
  'OFXHEADER' => '100'
  'DATA' => 'OFXSGML'
  'VERSION' => '102'
  'SECURITY' => 'TYPE1'
  'ENCODING' => 'USASCII'
  'CHARSET' => '1252'
  'COMPRESSION' => 'NONE'
  'OLDFILEUID' => 'NONE'
  'NEWFILEUID' => 'NONE'
}
```

#### Account

```ruby
ofx.account
=> { bank_id: '1', account_id: '1' }
```

#### Transactions

```ruby
ofx.transactions
=> [{
  type: "DEBIT",
  time: '2017-12-04 00:00:00 -0300'),
  amount: -99.99,
  fit_id: "00000000000000000000000000",
  name: "TRANSACTION DESCRIPTION"
}, ... ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Credits

This gem is based on [ofx](https://github.com/fnando/ofx).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/franciscomxs/ofx_reader.

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
ofx = OFXReader.(ofx_text)
=> #<OFXReader::Parser::Base:...
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

Will return a hash with all fields on .OFX file, using original names, as symbols:

```ruby
ofx.transactions
=> [{
  trntype: "DEBIT",
  dtposted: '20171214000000[-3:EST]'),
  trnamt: -99.99,
  fitid: "00000000000000000000000000",
  name: "TRANSACTION DESCRIPTION"
}, ... ]
```

You can also read a .OFX file in console using the `ofx_reader` executable:

```bash
$ ofx_reader path/to/file.ofx
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Credits

This gem is based on [ofx](https://github.com/fnando/ofx).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/franciscomxs/ofx_reader.

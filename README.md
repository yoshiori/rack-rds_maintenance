# Rack::RdsMaintenance

Rack::RdsMaintenance is a receive Amazon RDS maintenance notification interface for rack applications.

Auto subscribe for Amazon SNS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-rds_maintenance'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-rds_maintenance

## Usage

Set RDS Event Subscription.

see: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html

default endpoint is /rack_rds_maintenance

### for rails

```ruby
config.middleware.use Rack::RdsMaintenance,
  path: "/rds_maintenance",
  before_maintenance: -> { Rails.cache.write("rds", "maintenance") },
  after_maintenance: -> { Rails.cache.delete("rds") }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/yoshiori/rack-rds_maintenance/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# Doofenshmirtz

## Usage

Let your Rails code self destruct in tests.

Set an expiration date anywhere:

```ruby
Doofenshmirtz::SelfDestruct.on("2015-05-09")
```

and in your test environment, if it is before that date, it will display
a warning and let you know how much time you have until the self destruct
mechanism is activated. If it is after that date, it wil throw an exception
causing your tests to fail. In any other environment, it will just be ignored.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doofenshmirtz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doofenshmirtz


### Reporting

You can put the following in an `after_suite` callback (or anywhere really)
and output what self destruct mechanisms are currently enabled. For example in
rspec, you would put the following in your spec helper.

```ruby
config.after(:suite) do
  Doofenshmirtz::SelfDestruct.report
end
```

You can also pass a custom reporter class to customize the output.
All you need to implement is the `#report` method.

```ruby
Doofenshmirtz::SelfDestruct.report(MyCustomerReporter)
```

Here is an example of a simple one that prints to stdout:

```ruby
class MyCustomerReporter
  attr_accessor :mechanisms

  def initialize(mechanisms)
    self.mechanisms = mechanisms
  end

  def report
    mechanisms.each do |m|
      puts m.location
      puts m.time
      puts m.reason
    end
  end
end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/doofenshmirtz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

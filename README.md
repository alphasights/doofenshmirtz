# Doofenshmirtz

Let your Rails code self destruct in tests.

Set an expiration date anywhere:

```ruby
Doofenshmirtz::SelfDestruct.on(“2015-05-09”)
```

and watch it explode if the code is still around on that date. You’ll also
get warning messages in you test output to let you know that that there
are self desctruction mechanisms in the code and when they will blow up.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doofenshmirtz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doofenshmirtz

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/doofenshmirtz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

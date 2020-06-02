# Omnium

> "Your talk," I said, "is surely the handiwork of wisdom because not one word of it do I understand."

Omnium is
1. an ongoing educational project for learning how to write a programming language
2. an interpreter written in Ruby
3. a gem
4. a bicycle
5. quite the pancake

[![Build Status](https://travis-ci.org/ronanduddy/omnium.svg?branch=master)](https://travis-ci.org/ronanduddy/omnium)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omnium', git: "https://github.com/ronanduddy/omnium"
```

And then execute:

```Shell
bundle install
```

Or install it yourself as:

```Shell
gem install omnium
```

## Usage

```Shell
bundle exec omnium hello.om
{:a=>2, :b=>25, :y=>5.997142857142857}
```

## Development

After checking out the repo, run `make run file=hello.om` to run the example program. Then, run `make test` to run all the tests or `make guard` to use guard for testing. You can also run `make irb` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ronanduddy/omnium. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details on our code of conduct.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Brian O'Nolan
* [Ruslan Spivak](https://ruslanspivak.com)
* [Jonathan Blow](https://www.youtube.com/user/jblow888/)

# Markovite

Markovite is simple, but powerful markov chain generator that is designed to be hackable to your heart's delight. You can use this gem to generate official looking text with some training text AKA a corpus.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'markovite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markovite

## Usage

To hit the ground running, you can do the following:

```ruby
require "markovite"

chain = Markovite::Chain.new
chain << "tiny-shakespeare.txt"

chain.make_sentence_of_length(140)

```
This will train the chain model on a file named `tiny-shakespear.txt` and return a sentence that is no longer than 140 characters, which does not appear in the training corpus.

You can push multiple files or strings into one chain instance. By default, chains will be initialized with a depth of 2. 

### Expanding Chain
A new chain instance can optionally be initialized with
a filename as the first argument, and the desired depth size as the second argument.

`chain = Markovite::Chain.new("tiny-shakespeare.txt", 3)`

Instances of chains can be modified by using the more specific 
`chain.parse_file("sherlock.txt", 3)`
or
`chain.parse_string("I am a giant hamster person")`
The second argument, the chain depth, will default to 2.

### Creating Sentences

`chain.make_sentence`

Returns one sentence that does not appear in the corpus, or nil if the model is unable to generate a unique sentence.

`chain.make_sentences(5)`

Returns five sentences that do not appear in the corpus, or nil if the model is unable to generate a unique sentence.

`chain.make_sentence_starts_with("Hello listeners")`

Returns a sentence that begins with the argument, or nil if the model is unable to generate a unique sentence.

`chain.make_sentence_of_length(280)`

Returns a sentence with the length of 280 characters, or nil if the model is unable to generate a unique sentence.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/f3mshep/markovite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Markovite project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/f3mshep/markovite/blob/master/CODE_OF_CONDUCT.md).

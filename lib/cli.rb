load 'splitter.rb'
load 'dict.rb'
load 'chainer.rb'
load 'init.rb'
require 'pry'

chain = Markovable::Chain.new

chain.parse_file("nightvale_tweets.txt", 2)

binding.pry
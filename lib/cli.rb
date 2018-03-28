load 'splitter.rb'
load 'dict.rb'
load 'chainer.rb'
load 'init.rb'
require 'pry'

chain = Markovable::Chain.new

chain.parse_file("welcome_nightvale.txt", 2)

binding.pry
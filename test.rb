load 'splitter.rb'
load 'dict.rb'
load 'chainer.rb'
require 'pry'

file = File.read("welcome_nightvale.txt")

splitter = SplitSentence.new(file)

splitter.split_text

dict = Dictionary.new(splitter)

dict.construct_chain

chainer = Chainer.new(dict)
binding.pry
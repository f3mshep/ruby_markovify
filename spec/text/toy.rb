
require 'pry'
load '../../lib/markovite.rb'
require 'benchmark'

chain = Markovite::Chain.new

binding.pry

text = File.read("welcome_nightvale.txt")

splitter = SplitSentence.new("")



require 'pry'
load '../../lib/markovite.rb'
require 'benchmark'

chain = Markovite::Chain.new

binding.pry

text = File.read("welcome_nightvale.txt")

splitter = SplitSentence.new("")

puts "NEW SPLIT METHOD"
puts Benchmark.measure { splitter.split_text(text) }
splitter.clear_sentences
splitter.corpus.clear
puts "-------------------------------------------------------------------------"
puts "OLD SPLIT METHOD"
puts Benchmark.measure {splitter.old_split_text(text)}

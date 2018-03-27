require 'marky_markov'
require 'pry'

markov = MarkyMarkov::Dictionary.new('dictionary', 2)
markov.parse_file "welcome_nightvale.txt"
stuff = markov.generate_n_sentences(15)
binding.pry
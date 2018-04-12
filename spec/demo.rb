require_relative "config/environment.rb"
require "pry"

chain = Markovite::Chain.new("text/welcome_nightvale.txt")

binding.pry
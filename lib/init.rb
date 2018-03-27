#starts that shit
#class that will tie everything together
load 'splitter.rb'
load 'dict.rb'
load 'chainer.rb'
require 'pry'
module Markovable
  VERSION = '0.1.0'

  class Chain
    attr_accessor :dictionary, :chainer, :split, :depth


    def initialize

    end

    def parse_string()
    end

    def parse_file(filename, dict_depth=self.depth)
      File.open(filename, 'r') do |file|
        binding.pry
        split = SplitSentence.new(file)
      end
      dictionary = Dictionary.new(split, depth)
      chainer = Chainer.new(dictionary)
    end


    def <<()
    end

    def make_sentence
      raise "No corpus in memory" if dictionary.nil
      chainer.make_sentence
    end

    def make_sentences
    end

  end

end
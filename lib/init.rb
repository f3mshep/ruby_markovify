#class that will tie everything together
load 'splitter.rb'
load 'dict.rb'
load 'chainer.rb'
require 'pry'
module Markovable
  VERSION = '0.1.0'

  class Chain
    attr_accessor :dictionary, :chainer, :split, :depth, :corpus


    def initialize
    end

    def parse_string()
    end



    def parse_file(filename, dict_depth)

      File.open(filename, 'r') do |file|
        self.corpus = file.read
      end
      # This needs to be refactored
      # instance methods should not know the name of multiple
      # classes!
      self.split = SplitSentence.new(corpus)
      self.dictionary = Dictionary.new(split, dict_depth)
      self.chainer = Chainer.new(dictionary)
    end


    def <<()
    end

    def make_sentence
      chainer.make_sentence
    end

    def make_sentences(amount)
      chainer.make_sentences(amount)
    end

    def make_sentence_starts_with(phrase)
      chainer.make_sentence_starts_with(phrase)
    end

    def make_sentence_of_length(how_long)
      chainer.make_sentence_of_length(how_long)
    end

    private

    def default_depth
      return depth if depth
    end

  end

end
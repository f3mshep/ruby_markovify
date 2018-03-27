#starts that shit
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
      self.split = SplitSentence.new(corpus)
      self.dictionary = Dictionary.new(split, dict_depth)
      self.chainer = Chainer.new(dictionary)
    end


    def <<()
    end

    def make_sentence
      raise "No corpus in memory" if dictionary.nil?
      chainer.make_sentence
    end

    def make_sentences(amount)
      sentences = []
      amount.times do
        sentences << make_sentence
      end
      sentences.join(' ')
    end

    private

    def default_depth
      return depth if depth

    end

  end

end
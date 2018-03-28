#class that will tie everything together
load 'splitter.rb'
load 'dict.rb'
load 'chainer.rb'
require 'pry'

module Markovable
  VERSION = '0.1.0'
  FILE_EXT = [/.txt\z/i, /.rtf\z/i]
  class Chain
    attr_accessor :dictionary, :chainer, :split
    attr_reader :depth
    DEFAULT_DEPTH = 2

    def initialize(filename = nil, depth=DEFAULT_DEPTH)
      parse_file(filename, depth) if filename
    end

    def parse_string(text, dict_depth)
      if chainer
        add_from_text(text)
      else
        new_from_text(text, dict_depth)
      end
    end

    def parse_file(filename, dict_depth = DEFAULT_DEPTH)
      raise "Invalid file type" if !is_valid_file(filename)
      text = File.read(filename)
      parse_string(text, dict_depth)
    end

    def << (corpus)
      if is_valid_file(corpus)
        parse_file(corpus)
      else
        parse_string(corpus)
      end
    end

    ####Future Self: Make this a module####

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

    ####  ####

    private

    def new_from_text(text, dict_depth)
      #look into refactoring this
      @depth = dict_depth
      self.split = SplitSentence.new(text)
      self.dictionary = Dictionary.new(split, depth)
      self.chainer = Chainer.new(dictionary)
    end

    def is_valid_file(filename)
      re = Regexp.union(FILE_EXT)
      filename.match(re)
    end

    def add_from_text(text)
      dictionary.expand_chain(text)
    end

  end

end
require_relative "../config/environment"

module Markovite
  FILE_EXT = [/.txt\z/i, /.rtf\z/i]
  class Chain
    attr_accessor :dictionary, :chainer, :split
    attr_reader :depth
    MIN_DEPTH = 1
    MAX_DEPTH = 4
    DEFAULT_DEPTH = 2
    MAX_FILENAME_LENGTH = 255

    def initialize(filename = nil, dict_depth=DEFAULT_DEPTH)
      parse_file(filename, dict_depth) if filename
    end

    def parse_string(text, dict_depth=DEFAULT_DEPTH)
      depth_check(dict_depth)
      if chainer
        add_from_text(text)
      else
        new_from_text(text, dict_depth)
      end
    end

    def parse_file(filename, dict_depth = DEFAULT_DEPTH)
      raise "Invalid file type" if !is_valid_file_ext?(filename)
      text = File.read(filename)
      parse_string(text, dict_depth)
    end

    def << (corpus)
      if is_file?(corpus)
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

    def depth_check(dict_depth)
      if chainer
        raise "Chain depth conflict" if dict_depth != depth
      elsif !is_valid_depth?(dict_depth)
        raise "Chain depth must be between #{MIN_DEPTH} and #{MAX_DEPTH}"
      end
    end

    def is_valid_depth?(dict_depth)
      dict_depth >= MIN_DEPTH && dict_depth <= MAX_DEPTH
    end

    def split_words(str)
      str.split(" ")
    end

    def new_from_text(text, dict_depth)
      #look into refactoring this
      @depth = dict_depth
      self.split = SplitSentence.new(text)
      self.dictionary = Dictionary.new(split, depth)
      self.chainer = Chainer.new(dictionary)
    end

    def is_valid_file_ext?(filename)
      re = Regexp.union(FILE_EXT)
      filename.match(re)
    end

    def is_file?(str)
      str.length < 255 && split_words(str).length == 1
    end

    def add_from_text(text)
      dictionary.expand_chain(text)
    end

  end

end
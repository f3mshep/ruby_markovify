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
      initialize_children
      parse_file(filename, dict_depth) if filename
    end

    def save(filename)
      raise("Chain is empty") if dictionary.chain.empty?
      msg_hash = {}
      msg_hash["sentences"] = dictionary.sentences
      msg_hash["chain"] = dictionary.chain
      msg_hash["corpus"] = split.corpus
      msg_hash["depth"] = dictionary.depth
      File.open("#{filename}.msg", "w") do |file|
        test = file.write(msg_hash.to_msgpack)
      end
      true
    end

    def load(filename)
      raise("Invalid file type") if !is_valid_file_ext?(filename, /.msg\z/i)
      data = File.read("#{filename}")
      model = MessagePack.unpack(data)
      @depth = model["depth"]
      split.corpus = model["corpus"]
      dictionary.sentences = model["sentences"]
      dictionary.chain = model["chain"]
    end

    def self.combine(left_chain, right_chain, dict_depth = nil)
      dict_depth = dict_depth || left_chain.depth
      new_chain = Markovite::Chain.new
      new_chain.parse_string(left_chain.corpus, dict_depth)
      new_chain.parse_string(right_chain.corpus, dict_depth)
      new_chain
    end

    def corpus
      split.corpus
    end

    def parse_string(text, dict_depth = nil)
      if self.depth
        depth_check(dict_depth)
        add_from_text(text)
      else
        dict_depth = dict_depth || DEFAULT_DEPTH
        is_valid_depth?(dict_depth)
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
        raise "Chain depth conflict" if !dict_depth.nil? && dict_depth != depth
    end

    def is_valid_depth?(dict_depth)
      dict_depth >= MIN_DEPTH && dict_depth <= MAX_DEPTH
    end

    def split_words(str)
      str.split(" ")
    end

    def new_from_text(text, dict_depth)
      @depth = dict_depth
      @corpus = split.corpus
      dictionary.expand_chain(text)
    end


    def is_valid_file_ext?(filename, ext = nil)
      re = ext || Regexp.union(FILE_EXT)
      filename.match(re)
    end

    def is_file?(str)
      str.length < 255 && split_words(str).length == 1
    end

    def initialize_children
      self.split = SplitSentence.new
      self.dictionary = Dictionary.new({sentence_split: split})
      self.chainer = Chainer.new(dictionary)
    end

    def add_from_text(text)
      dictionary.expand_chain(text)
    end

  end

end
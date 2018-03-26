#class that takes a training corpus and creates a chain dictionary
require 'pry'


class Dictionary

  BEGINNING = "__BEGIN__"
  ENDING = "__END__"
  attr_accessor :chain, :sentence_split

  def initialize(sentences)
    # sentences is a splitter object, will use the attr_accessor
    # as a public interface
    self.sentence_split = sentences
    self.chain = Hash.new { |h, k| h[k] = [] }
  end

  def construct_chain
    #for each word in each sentence
    #nil is  beginning of sentence
    #head is key, points to an array. Word after head will be pushed into array
    #head will then become the next word
    #nil is falsy in ruby, this might cause issues to set the empty indicator as
    # nil.
    sentences = sentence_split.sentences
    sentences.each do |sentence|
      words = sentence.split(" ")
      head = BEGINNING
      words.each do |word|
        chain[head] << word
        head = word
      end
      chain[head] << ENDING
    end
    chain
  end

end
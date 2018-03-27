#class that takes a training corpus and creates a chain dictionary
require 'pry'


class Dictionary

  #make this a module???
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
      chunk = [BEGINNING, BEGINNING]
      words.each do |word|
        # using a clone of the chunk ensures the VALUE
        # of the chunk is used as the key, instead of
        # whatever is stored at the memory address
        # of the initial chunk
        chain[chunk.clone] << word
        chunk.shift
        chunk.push(word)
      end
      chain[chunk] << ENDING
    end
    chain
    binding.pry
  end

end
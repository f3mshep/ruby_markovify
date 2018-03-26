#class that takes a training corpus and creates a chain dictionary



class Dictionary

  attr_accessor :chain

  def initialize(sentences)
    # sentences is a splitter object, will use the attr_accessor
    # as a public interface
    self.sentences = sentences
  end

  def construct_chain
    #for each word in each sentence
    #nil is for beginning of sentence
    #head is key, points to an array. Word after head will be pushed into array
    #head will then become the next word
  end

end
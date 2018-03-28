# class that takes a training corpus and creates a hash that represents
# a markov chain state machine

class Dictionary

  #make this a module???
  BEGINNING = "__BEGIN__"
  ENDING = "__END__"

  attr_accessor :chain, :sentence_split, :sentences
  attr_reader :depth
  def initialize(sentence_split, depth = 2)
    self.sentence_split = sentence_split
    # The following line ensures a new array is created for each new key
    # instead of using the memory address of the first array created
    # as the default value
    self.chain = Hash.new { |h, k| h[k] = [] }
    self.sentences = sentence_split.sentences
    @depth = depth
    construct_chain
  end

  def has_sentence(sentence)
    sentences.include?(sentence)
  end

  def self.load_from_file

  end

  def save_to_file

  end

  def construct_chain
    sentences.each do |sentence|
      words = sentence.split(" ")
      # each chunk is an array that represents a state in the markov chain
      # it is a key that points to the next possible states
      chunk = [BEGINNING] * depth
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
  end

end
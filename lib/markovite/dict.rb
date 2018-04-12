# class that takes a training corpus and creates a hash that represents
# a markov chain state machine

class Dictionary

  #make this a module???
  BEGINNING = "__BEGIN__"
  ENDING = "__END__"
  DEFAULT_DEPTH = 2

  attr_accessor :sentence_split, :sentences
  attr_reader :depth, :chain

  def initialize(attributes)
    attributes.each {|attribute, value| self.send("#{attribute}=", value)}
    set_default
  end

  def has_sentence(sentence)
    sentences.include?(sentence)
  end

  def chain=(arg)
    # The following line ensures a new array is created for each new key
    # instead of using the memory address of the first array created
    # as the default value
    @chain = Hash.new { |h, k| h[k] = [] } if self.chain.nil?
    arg.each {|key, value|chain[key] = value}
    chain
  end

  def depth=(arg)
    raise "Depth cannot be changed" if depth
    raise "Depth must be integer" if arg.class != Integer
    @depth = arg
  end

  def expand_chain(text)
    new_sentences = sentence_split.split_text(text)
    sentence_split.expand_corpus(text)
    self.sentences += new_sentences
    construct_chain(new_sentences)
  end

  def construct_chain(new_sentences = nil)
    new_sentences = new_sentences || sentences
    # raise "No sentences in memory" if new_sentences.empty?
    new_sentences.each do |sentence|
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

  def clear_chain
    chain.clear
  end

  def clear_sentences
    sentences.clear
  end

  private

  def set_default
    self.sentence_split = sentence_split || SentenceSplit.new
    self.chain = chain || {}
    self.sentences = sentences || sentence_split.split_text
    self.depth = depth || DEFAULT_DEPTH
    construct_chain if chain.empty?
  end

end
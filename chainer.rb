# class that takes a dictionary class
class Chainer

  attr_accessor :dictionary
  attr_reader :depth
  # perhaps chainer can have options to toggle on grammar rules

  BEGINNING = "__BEGIN__"
  ENDING = "__END__"
  MAX_ATTEMPS = 15

  def initialize(dictionary)
    self.dictionary = dictionary
    @depth = 2
    #takes in a dictionary object
    #constructs chain from dictionary object public interface
  end



  def make_sentence
    # DO NOT KEEP RECUSION HERE IT IS QUICK AND DIRTY
    # WE COULD GET A VICIOUS, VICIOUS CALL STACK ERROR.
    sentence = generate_text
    if test_sentence(sentence)
      return sentence
    else
      make_sentence
    end
  end

  private

  def pick_next(words)
    word_list = dictionary.chain[words]
    word_list.sample
  end

  def remove_markers(sentence)
    sentence.pop
    sentence.shift(depth)
  end

  def test_sentence(sentence)
    !dictionary.sentences.include?(sentence)
  end


  def generate_text
    current_chunk = [BEGINNING] * depth
    sentence = current_chunk
    while current_chunk.last != ENDING
      sentence << pick_next(current_chunk)
      current_chunk = sentence.last(depth)
    end
    remove_markers(sentence)
    sentence.join(' ')
  end

  #will either pick a random word to start with or a supplied one. Maybe weigtht
  #towards nil?

end
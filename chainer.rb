# class that takes a dictionary class
class Chainer

  attr_accessor :dictionary

  # perhaps chainer can have options to toggle on grammar rules

  BEGINNING = "__BEGIN__"
  ENDING = "__END__"


  def initialize(dictionary)
    self.dictionary = dictionary
    #takes in a dictionary object
    #constructs chain from dictionary object public interface
  end

  def pick_next(word)
    word_list = dictionary.chain[word]
    size = word_list.size
    word_list[rand(0...size)]
  end

  def make_sentence
    current_word = pick_next(BEGINNING)
    sentence = []
    while current_word != ENDING
      sentence << current_word
      current_word = pick_next(current_word)
    end
    sentence.join(' ')
  end

  #will either pick a random word to start with or a supplied one. Maybe weigtht
  #towards nil?

end
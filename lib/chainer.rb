# class
class Chainer

  attr_accessor :dictionary
  attr_reader :depth
  # perhaps chainer can have options to toggle on grammar rules

  BEGINNING = "__BEGIN__"
  ENDING = "__END__"
  MAX_ATTEMPTS = 15

  def initialize(dictionary)
    self.dictionary = dictionary
    @depth = dictionary.depth
    #takes in a dictionary object
    #constructs chain from dictionary object public interface
  end

  def sentence_starts_with(phrase)
    chunk = get_chunk(phrase)
    partial = generate_text(chunk)
    "#{phrase} #{partial}"
  end

  def make_sentence
    attempts = 0
    while attempts < MAX_ATTEMPTS
      sentence = generate_text
      if valid_sentence(sentence)
        return sentence
      else
        attempts += 1
      end
    end
    nil
  end

  private

  def get_chunk(phrase)
    words = phrase.split(' ')
    chunk = words.last(depth)
    while chunk.size < depth
      chunk.unshift(BEGINNING)
    end
    chunk
  end

  def pick_next(words)
    word_list = dictionary.chain[words]
    raise "No matching state found" if word_list.empty?
    word_list.sample
  end

  def remove_markers(sentence)
    #removes BEGINNING and ENDING markers
    sentence.pop
    sentence.shift(depth)
  end

  def valid_sentence(sentence)
    !dictionary.has_sentence(sentence)
  end


  def generate_text(current_chunk = [BEGINNING] * depth)
    sentence = current_chunk
    while current_chunk.last != ENDING
      sentence << pick_next(current_chunk)
      current_chunk = sentence.last(depth)
    end
    remove_markers(sentence)
    sentence.join(' ')
  end

end
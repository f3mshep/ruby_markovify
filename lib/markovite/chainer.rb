# class
class Chainer

  attr_accessor :dictionary
  attr_reader :depth

  BEGINNING = "__BEGIN__"
  ENDING = "__END__"
  MAX_ATTEMPTS = 15

  def initialize(dictionary)
    self.dictionary = dictionary
    @depth = dictionary.depth
    #takes in a dictionary object
    #constructs chain from dictionary object public interface
  end

  def make_sentence_starts_with(phrase)
    chunk = get_chunk(phrase)
    begin
      partial = generate_text(chunk)
    rescue ArgumentError
      return nil
    end
    "#{phrase} #{partial}"
  end

  def make_sentence_of_length(how_long)
    begin
      make_sentence_with_block {|sentence| sentence.length <= how_long}
    rescue NoMethodError
      return nil
    end
  end

  def make_sentences(amount, condition=true)
    sentences = []
    amount.times do
      sentences << make_sentence
    end
    sentences.join(' ')
  end

  def depth=(arg)
    raise "Depth cannot be changed"
  end

  def make_sentence
    raise "No corpus in memory" if dictionary.nil?
    attempts = 0
    while attempts < MAX_ATTEMPTS
      sentence = generate_text
      if is_valid_sentence?(sentence)
        return sentence
      else
        attempts += 1
      end
    end
    nil
  end

  private

  def make_sentence_with_block
    attempts = 0
    while attempts < MAX_ATTEMPTS
      sentence = make_sentence
      if yield(sentence)
        return sentence
      else
        attempts += 1
      end
    end
  end

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
    raise ArgumentError, "No matching state" if word_list.empty?
    word_list.sample
  end

  def remove_markers(sentence)
    #removes BEGINNING and ENDING markers
    sentence.shift while sentence.first == BEGINNING
    sentence.pop while sentence.last == ENDING
    sentence
  end

  def is_valid_sentence?(sentence)
    !dictionary.has_sentence(sentence)
  end

  def has_open_quote?(sentence)
    count = sentence.count("\"")
    count.odd?
  end

  def close_open_quote(sentence)
    if has_open_quote?(sentence)
      "#{sentence}\""
    else
      sentence
    end
  end

  def generate_text(current_chunk = [BEGINNING] * depth)
    sentence = current_chunk
    while current_chunk.last != ENDING
      sentence << pick_next(current_chunk)
      current_chunk = sentence.last(depth)
    end
    remove_markers(sentence)
    sentence = sentence.join(' ')
    close_open_quote(sentence)
  end

end
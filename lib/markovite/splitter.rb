#class that takes a corpus and breaks it down into arrays.
#each array is one sentence.

class SplitSentence

  ENDERS = ['?', '.', '!']
  ABBREVIATIONS = [
    'ave.','blvd.','ln','rd.','st.', #directional
    'tsp.','t.', 'tbs.', 'tbsp.','gal.','lb.','pt.','qt.', #cooking
    "ak.", "al.", "ar.", "az.", "ca.", "co.", "ct.", "dc.", "de.", "fl.",
    "ga.", "gu.", "hi.", "ia.", "id.", "il.", "in.", "ks.", "ky.", "la.",
    "ma.", "md.", "me.", "mh.", "mi.", "mn.", "mo.", "ms.", "mt.", "nc.",
    "nd.", "ne.", "nh.", "nj.", "nm.", "nv.", "ny.", "oh.", "ok.", "or.",
    "pa.", "pr.", "pw.", "ri.", "sc.", "sd.", "tn.", "tx.", "ut.", "va.",
    "vi.", "vt.", "wa.", "wi.", "wv.", "wy.",  "u.s.", "u.s.a,", #us locations
    "dr.", "esq.", "jr.", "mr.", "mrs.", "ms.", "mx.",
    "prof.", "rev.", "rt. hon.", "sr.", "st." #personal
  ]

  #look into detecting abbreviations!

  attr_accessor :corpus

  def initialize(corpus = "")
    self.corpus = corpus.dup
    split_text
  end

  def clear_sentences
    sentences.clear
  end

  # We will want to change this to something that splits the words into an
  # array, then we will make another pass through the word array to find
  # where a sentence begins and ends

  # might be cool to count punct. separately, we can point to punct as a way to indicate the end. if the
  # sentences are delimited by \n, we can have nil be the value it points to instead.
  # This way, we can impose grammatical rules by making the first word of the sentence
  # capitalized, and the end of the sentence will end with some sort of punctuation.

  def split_text(new_text = nil)
    clear_sentences
    current_sentence = []
    new_text = new_text || corpus
    all_words = split_words(new_text)
    all_words.each do |word|
      if is_end_of_sentence?(word)
        current_sentence = add_sentence(current_sentence, word)
      elsif has_newline?(word)
        newline_words = split_newline(word)
        current_sentence = add_sentence(current_sentence, newline_words[0])
        current_sentence << newline_words[1]
      else
        current_sentence << word
      end
    end
    add_sentence(current_sentence, nil) if !current_sentence.empty?
    sentences
  end

  def expand_corpus(text)
    self.corpus += "\n" + text
  end

  private

  def add_sentence(sentence, word)
    sentence << word if word
    sentences << sentence.compact.join(" ")
    []
  end

  def split_words(text)
    text.split(/ /)
  end

  def is_abbreviation(word)
    ABBREVIATIONS.include?(word.downcase)
  end

  def has_newline?(word)
    word.include?("\n")
  end

  def split_newline(word)
    word.split("\n").map{|str| str.empty? ? nil:str}
  end

  def is_end_of_sentence?(word)
    #check punctuation before delving into abbreviations to save time
    return false if !ENDERS.include?(word[-1])
    return false if is_abbreviation(word)
    return true
  end

end
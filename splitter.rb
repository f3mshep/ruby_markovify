#class that takes a corpus and breaks it down into arrays.
#each array is one sentence.

class Splitter

  SPLITTERS = ['\n', '?', '.', ',', '!']

  attr_accessor :sentences, :corpus

  def initialize(corpus)
    self.corpus = corpus
    self.sentences = []
  end

  def split_text
    current_sentence = ""
    corpus.each_char do |char|
      if SPLITTERS.include?(char)
        current_sentence << char
        self.sentences << current_sentence
        current_sentence = ""
      else
        current_sentence << char
      end
    end
    sentences
  end

end
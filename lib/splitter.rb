#class that takes a corpus and breaks it down into arrays.
#each array is one sentence.

class SplitSentence

  SPLITTERS = ['\n', '?', '.', '!']

  #look into detecting abbreviations!

  attr_accessor :sentences, :corpus

  def initialize(corpus)
    self.corpus = corpus
    self.sentences = []
  end


  # We will want to change this to something that splits the words into an
  # array, then we will make another pass through the word array to find
  # where a sentence begins and ends

  # might be cool to count punct. separately, we can point to punct as a way to indicate the end. if the
  # sentences are delimited by \n, we can have nil be the value it points to instead.
  # This way, we can impose grammatical rules by making the first word of the sentence
  # capitalized, and the end of the sentence will end with some sort of punctuation.



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

  private

end
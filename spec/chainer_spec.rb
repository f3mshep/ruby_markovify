require "spec_helper"

corpus = File.read("spec/text/test_chunk.txt")
splitter = SplitSentence.new(corpus)
dictionary = Dictionary.new(splitter)
chainer = Chainer.new(dictionary)
test_batch = 10

describe Chainer do

  describe ".initialize" do
    context "When initialized" do
      it "sets #dictionary" do
        expect(chainer.dictionary).to_not be_nil
      end
      it "sets #depth based on #dictionary" do
        expect(chainer.depth).to eq(dictionary.depth)
      end
    end
  end

  describe "#make_sentence_starts_with" do
    it "makes sentence that starts with argument" do
      new_sentence = chainer.make_sentence_starts_with("I am")
      test_chunk = new_sentence.slice(0,4)
      expect(test_chunk).to eq("I am")
      expect(new_sentence.length).to be > 4
    end
  end



  describe "#make_sentence" do
    context "When called" do
      it "makes a sentence" do
        new_sentence = chainer.make_sentence
        expect(new_sentence).to be_a(String)
        expect(new_sentence.length).to be > 0
      end
      it "closes open quotation marks" do
        pending("Implementation")
      end
      it "validates sentence is not present in corpus" do
        pending("Implementation")
      end
      it "will return nil if it can't create sentence" do
        pending("Implementation")
      end
    end
  end

  describe "#make_sentence_of_length" do
    it "makes sentence of character length less than argument" do
      test_batch.times do
        new_sentence = chainer.make_sentence_of_length(140)
        expect(new_sentence.length).to be <= 140
      end
    end
  end
end
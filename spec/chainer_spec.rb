require "spec_helper"

corpus = File.read("spec/text/test_chunk.txt")
splitter = SplitSentence.new(corpus)
dictionary = Dictionary.new(splitter)
chainer = Chainer.new(dictionary)
test_corpus = File.read("spec/text/test_file.txt")
test_splitter = SplitSentence.new(test_corpus)
test_dictionary = Dictionary.new(test_splitter)
test_chainer = Chainer.new(test_dictionary)
test_batch = 100

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
    it "returns nil if it is unable to make a sentence" do
      raise "Not implemented yet."
    end
  end

  describe "#make_sentence" do
    context "When called" do
      it "makes a sentence" do
        new_sentence = chainer.make_sentence
        expect(new_sentence).to be_a(String)
        expect(new_sentence.length).to be > 0
      end
      it "closes open double quotation marks" do
        test_batch.times do
          new_sentence = chainer.make_sentence
          until new_sentence.include?("\"")
            new_sentence = chainer.make_sentence
          end
          count = new_sentence.count("\"")
          expect(count.even?).to be true
        end
      end
      it "validates sentence is not present in corpus" do
        new_sentence = chainer.make_sentence
        expect(chainer.send(:is_valid_sentence?, new_sentence)).to be true
      end
      it "will return nil if it can't create sentence" do
        expect(test_chainer.make_sentence).to eq(nil)
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
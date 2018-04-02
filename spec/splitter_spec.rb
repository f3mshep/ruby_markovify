require "spec_helper"



test_text = "The quick brown fox jumps over the lazy dog. Wheee!"

split_output = ["The quick brown fox jumps over the lazy dog.", "Wheee!"]

splitter = SplitSentence.new(test_text)

describe SplitSentence do

  describe "#corpus" do
    it "responds to #corpus" do
      expect(splitter).to respond_to(:corpus)
    end
  end

  describe ".new" do
    context "When initializing" do
      it "generates a new instance of a splitter with a corpus" do
        expect(splitter.corpus).not_to be_empty
      end
    end
  end

  describe "#split_sentence" do
    context "When given a corpus" do
      it "finds sentences, and splits them into arrays" do
        sentences = splitter.split_text
        expect(sentences).to eq(split_output)
      end
      it "properly splits linebreaks" do
        linebreak_test = SplitSentence.new("Hello Bigfoot \nI hear ducks!")
        expected = ["Hello Bigfoot", "I hear ducks!"]
        expect(linebreak_test.split_text).to eq(expected)
        linebreak_test = SplitSentence.new("Hello Bigfoot\n I hear ducks!")
        expect(linebreak_test.split_text).to eq(expected)
      end
      it "ignores common abbreviated titles" do
        title_test = SplitSentence.new("Hello Mr. Bigfoot")
        expected = ["Hello Mr. Bigfoot"]
        expect(title_test.split_text).to eq(expected)
      end
      it "ignores common abbreviated addresses" do
        time_test = SplitSentence.new("I live on 12th ave. and it is very windy")
        expected = ["I live on 12th ave. and it is very windy"]
        expect(time_test.split_text).to eq(expected)
      end
    end
  end
end





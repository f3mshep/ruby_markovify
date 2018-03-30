require "spec_helper"

corpus = File.read("spec/text/test_file.txt")
splitter = SplitSentence.new(corpus)
dictionary = Dictionary.new(splitter)
test_chain = {["__BEGIN__", "__BEGIN__"]=>["I", "Hello", "One"],
 ["__BEGIN__", "I"]=>["am"],
 ["I", "am"]=>["a"],
 ["am", "a"]=>["test"],
 ["a", "test"]=>["string."],
 ["test", "string."]=>["__END__"],
 ["__BEGIN__", "Hello"]=>["biscuits?"],
 ["Hello", "biscuits?"]=>["__END__"],
 ["__BEGIN__", "One"]=>["and"],
 ["One", "and"]=>["two"],
 ["and", "two"]=>["and"],
 ["two", "and"]=>["three!"],
 ["and", "three!"]=>["__END__"]}

describe Dictionary do

  describe ".initialize" do
    context "When initialized" do
      it "Constructs a hash that serves as Markov chain receptacle" do
        expect(dictionary.chain).to be_a(Hash)
      end
      it "constructs a markov chain" do
        expect(dictionary.chain).not_to be_empty
      end
      it "sets depth with a default value of 2" do
        expect(dictionary.depth).to eq(2)
      end
    end
  end

  describe "#has_sentence" do
    it "Returns true if a sentence is present" do
      expect(dictionary.has_sentence("One and two and three!")).to eq(true)
    end
    it "Returns false if a sentence is present" do
      expect(dictionary.has_sentence("GA-GA OOOOH LA LA!")).to eq(false)
    end
  end

  describe "#depth" do
    it "Is immutable" do
      expect {dictionary.depth = 3}.to raise_error()
    end
  end

  describe "#chain" do
    it "Represents a markov state chain using a hash" do
      expect(dictionary.chain).to be_a(Hash)
    end
  end

  describe "#sentence_split" do
    it "Points to an object that responds to #sentences" do
      expect(dictionary.sentence_split).to respond_to(:sentences)
    end
  end

  describe "#sentences" do
    it "Is an array of sentences" do
      expect(dictionary.sentences).to be_a(Array)
      expect(dictionary.sentences.length).to be > 0
    end
  end

  describe "#construct_chain" do
    before :each do
      @new_dict = Dictionary.new(splitter)
    end
    context "When called" do
      it "constructs a markov chain" do
        @new_dict.clear_chain
        expect(@new_dict.construct_chain).to eq(test_chain)
      end
      it "Raises an error if there are no sentences" do
        @new_dict.clear_sentences
        expect { @new_dict.construct_chain }.to raise_error("No sentences in memory")
      end
    end
  end

end
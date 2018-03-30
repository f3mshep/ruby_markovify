require 'spec_helper'

test_file = "spec/text/test_file.txt"
additional_file = "spec/text/additional_file.txt"
bad_file = "text.zz"
test_string = "I am a test string. Hello biscuits? One and two and three!"
additional_string = "I am another string."
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
 additional_chain = {["__BEGIN__", "__BEGIN__"]=>["I", "Hello", "One", "I"],
 ["__BEGIN__", "I"]=>["am", "am"],
 ["I", "am"]=>["a", "another"],
 ["am", "a"]=>["test"],
 ["a", "test"]=>["string."],
 ["test", "string."]=>["__END__"],
 ["__BEGIN__", "Hello"]=>["biscuits?"],
 ["Hello", "biscuits?"]=>["__END__"],
 ["__BEGIN__", "One"]=>["and"],
 ["One", "and"]=>["two"],
 ["and", "two"]=>["and"],
 ["two", "and"]=>["three!"],
 ["and", "three!"]=>["__END__"],
 ["am", "another"]=>["string."],
 ["another", "string."]=>["__END__"]}


describe Markovable::Chain do
  before :each do
    @chain = Markovable::Chain.new
  end

  describe ".initialize" do
    context "When initializing" do
      it "parses a file if provided as argument" do
        @chain = Markovable::Chain.new(test_file)
        expect(@chain.chainer).to be_a(Chainer)
      end
      it "raises error if filename is not valid" do
        expect {Markovable::Chain.new(bad_file)}.to raise_error("Invalid file type")
      end
    end
  end
    describe "#dictionary" do
      it "is an instance of the Dictionary class" do
        @chain << test_file
        expect(@chain.dictionary).to be_a(Dictionary)
      end
    end
    describe "#chainer" do
      it "is an instance of the Chainer class" do
        @chain << test_file
        expect(@chain.chainer).to be_a(Chainer)
      end
    end
    describe "#split" do
      it "is an instance of the SplitSentence class" do
        @chain << test_file
        expect(@chain.split).to be_a(SplitSentence)
      end
    end

  describe "#parse_string" do
    context "when called" do
      it "can create a new chain from a string" do
        @chain.parse_string(test_string)
        expect(@chain.dictionary.chain).to eq(test_chain)
      end
      it "can properly add a corpus to existing chain" do
        @chain.parse_string(test_string)
        @chain.parse_string(additional_string)
        expect(@chain.dictionary.chain).to eq(additional_chain)
      end
    end
  end

  describe "#parse_file" do
    context "when called" do
      it "can create a new chain from a file" do
        @chain.parse_file(test_file)
        expect(@chain.dictionary.chain).to eq(test_chain)
      end
      it "can properly add a corpus to existing chain" do
        @chain.parse_file(test_file)
        @chain.parse_file(additional_file)
        expect(@chain.dictionary.chain).to eq(additional_chain)
      end
      it "will reject files of invalid extension" do
        expect {@chain.parse_file(bad_file)}.to raise_error("Invalid file type")
      end
    end
  end

  describe "#<<" do
    context "when called on a file" do
      it "can create a new chain from a file" do
        @chain << test_file
        expect(@chain.dictionary.chain).to eq(test_chain)
      end
      it "can properly add a corpus to existing chain" do
        @chain << test_file
        @chain << additional_file
        expect(@chain.dictionary.chain).to eq(additional_chain)
      end
      it "will reject files of invalid extension" do
        expect { @chain << bad_file }.to raise_error("Invalid file type")
      end
    end
    context "when called on a string" do
      it "can create a new chain from a string" do
        @chain << test_string
        expect(@chain.dictionary.chain).to eq(test_chain)
      end
      it "can properly add a corpus to existing chain" do
        @chain<<test_file
        @chain<<additional_string
        expect(@chain.dictionary.chain).to eq(additional_chain)
      end
    end
  end
end
require 'spec_helper'

test_file = "spec/text/test_file.txt"
bad_file = "text.zz"
test_string = "I am a test string. Hello biscuits? One and two and three!"

describe Markovable::Chain do
  before :each do
    @chain = Markovable::Chain.new
  end

  describe ".initialize" do
    context "When initializing" do
      it "parses a file if provided as argument" do
      end
      it "raises error if filename is not valid" do

        expect {Markovable::Chain.new(bad_file)}.to raise_error
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
      end
      it "can properly add a corpus to existing chain" do
      end
    end
  end

  describe "#parse_file" do
    context "when called" do
      it "can create a new chain from a file" do
      end
      it "can properly add a corpus to existing chain" do
      end
      it "will reject files of invalid extension" do
      end
    end
  end

  describe "#<<" do
    context "when called on a file" do
      it "can create a new chain from a file" do
      end
      it "can properly add a corpus to existing chain" do
      end
      it "will reject files of invalid extension" do
        expect { chain << bad_file }.to raise_error
      end
    end
    context "when called on a string" do
      it "can create a new chain from a string" do
      end
      it "can properly add a corpus to existing chain" do
      end
    end
  end
end
require 'spec_helper'

test_file = "spec/text/test_file.txt"
additional_file = "spec/text/additional_file.txt"
bad_file = "text.zz"
test_string = "I am a test string. Hello biscuits? One and two and three!"
additional_string = "I am another string."
third_string = "Step away from the carrots."
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
 third_chain = {["__BEGIN__", "__BEGIN__"]=>["I", "Hello", "One", "I", "Step"],
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
 ["another", "string."]=>["__END__"],
 ["__BEGIN__", "Step"]=>["away"],
 ["Step", "away"]=>["from"],
 ["away", "from"]=>["the"],
 ["from", "the"]=>["carrots."],
 ["the", "carrots."]=>["__END__"]}

def chain_matcher(left, right)
  left_hash = to_chain_hash(left)
  right_hash = to_chain_hash(right)
  left_hash.keys.each do |key|
    expect(left_hash[key]).to match_array(right_hash[key])
  end
end

def to_chain_hash(target)
  return target if target.class == Hash
  target.dictionary.chain
end

describe Markovite::Chain do
  before :each do
    @chain = Markovite::Chain.new
  end

  describe ".combine" do
    before :each do
      @chain = Markovite::Chain.new
      @chain.parse_file(test_file, 3)
      @chain_dup = Markovite::Chain.new(additional_file)
      @combined_chain = Markovite::Chain.combine(@chain, @chain_dup)

    end
    context "when called with 2 chain instances" do
      it "creates a new Chain instance" do
        expect(@combined_chain).to be_a(Markovite::Chain)
      end
      it "generates a valid chain" do
        chain_depth_two = Markovite::Chain.combine(@chain, @chain_dup,2)
        expect(chain_depth_two.dictionary.chain).to eq(additional_chain)
      end
      it "defaults to using the depth of the first chain" do
        expect(@combined_chain.depth).to eq(@chain.depth)
      end
      it "sets the chain depth appropriately if specified" do
        specific_depth = Markovite::Chain.combine(@chain, @chain_dup, 1)
        expect(specific_depth.depth).to eq(1)
      end
      it "can combine multiple times" do
        third_string_chain = Markovite::Chain.new
        third_string_chain << third_string
        final_chain = Markovite::Chain.combine(third_string_chain, @combined_chain)
        chain_matcher(final_chain, third_chain)
        # final_hash = final_chain.dictionary.chain
        # final_hash.keys.each do |key|
        #   expect(final_hash[key]).to match_array(third_chain[key])
        # end
      end
    end
  end




  describe ".initialize" do
    context "When initializing" do
      it "parses a file if provided as argument" do
        @chain = Markovite::Chain.new(test_file)
        expect(@chain.chainer).to be_a(Chainer)
      end
      it "raises error if filename is not valid" do
        expect {Markovite::Chain.new(bad_file)}.to raise_error("Invalid file type")
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
      it "can create chains of different lengths" do
        chain_one = Markovite::Chain.new
        chain_three = Markovite::Chain.new
        chain_one.parse_string(additional_string,1)
        expect(chain_one.depth).to eq(1)
        chain_three.parse_string(additional_string,3)
        expect(chain_three.depth).to eq(3)
      end
      it "will raise an exception if there is a chain depth conflict" do
        @chain.parse_string(additional_string, 3)
        expect {@chain.parse_string(additional_string, 2)}.to raise_error("Chain depth conflict")
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
      it "can create chains of different lengths" do
        chain_one = Markovite::Chain.new
        chain_three = Markovite::Chain.new
        chain_one.parse_file(test_file,1)
        expect(chain_one.depth).to eq(1)
        chain_three.parse_file(test_file,3)
        expect(chain_three.depth).to eq(3)
      end
      it "will raise an exception if there is a chain depth conflict" do
        @chain.parse_file(test_file, 3)
        expect {@chain.parse_file(additional_file, 2)}.to raise_error("Chain depth conflict")
      end
      it "will reject files of invalid extension" do
        expect {@chain.parse_file(bad_file)}.to raise_error("Invalid file type")
      end
    end
  end

  describe "#save" do
    before :each do
      @blank_chain = Markovite::Chain.new
    end
    context "when called without an associated chainer instance" do
      it "throws an error" do
        expect {@blank_chain.save("test")}.to raise_error("No associated chain")
      end
    end
    context "when properly called" do
      it "creates a valid file that matches the filename argument" do
        @chain << test_file
        @chain.save("./spec/temp/new_test_file")
        expect(File).to exist("./spec/temp/new_test_file.msg")
      end
      it "creates a file with properly encoded JSON that matches chain" do
        @chain << test_file
        @chain.save("./spec/temp/save_test")
        json_file = File.read("./spec/temp/save_test.msg")
        test_hash = MessagePack.unpack(json_file)
        chain_matcher(@chain, test_hash["chain"])
      end
    end
  end


  describe "#load" do
    before :each do
      @blank_chain = Markovite::Chain.new
    end
    context "when called with an invalid file type" do
      it "throws an error" do
        expect {@blank_chain.load("invalid_file.txt")}.to raise_error("Invalid file type")
      end
    end
    context "when called with a valid file" do
      it "reconstitutes a chainer instance from file" do
        @chain.parse_file(test_file)
        @chain.save("./spec/temp/test_file")
        @blank_chain.load("./spec/temp/test_file.msg")
        chain_matcher(@chain, @blank_chain)
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
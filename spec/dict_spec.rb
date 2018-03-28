require "spec_helper"

corpus = File.read("text/welcome_nightvale.txt")
splitter = SplitSentence.new(corpus)
dictionary = Dictionary.new(splitter)


describe ".initialize" do
  context "When initialized" do
    it "Constructs a hash that serves as Markov chain receptacle" do
      (dictionary.chain).should_be_kind_of(Hash)
    end
    it "calls #construct_chain on initialization" do
    end
    it "sets depth with a default value of 2" do
    end
  end
end

describe "#has_sentence" do
  it "Returns a boolean if sentence is present" do
  end
end

describe "#depth" do
  it "Is assigned a value on initiation" do
  end
  it "Is immutable" do
  end
end

describe "#chain" do
  it "Represents a markov state chain using a hash" do
  end
end

describe "#sentence_split" do
  it "Points to an object that responds to #sentences" do
  end
end

describe "#sentences" do
  it "Contains each sentence in the corpus using an array" do
  end
end

describe "#construct_chain" do
  context "When called" do
    it "Raises an error if there are no sentences" do
    end
    it "Creates a markov chain using #sentences" do
    end
  end
end
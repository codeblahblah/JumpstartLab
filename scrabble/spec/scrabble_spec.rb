require './lib/scrabble'
require 'rspec'

describe Scrabble do
  describe ".score" do
    it "scores a single letter" do
      expect( Scrabble.score("a") ).to eq 1
      expect( Scrabble.score("f") ).to eq 4
    end

    it "scores an empty word" do
      expect( Scrabble.score("") ).to eq 0
    end

    it "scores a nil" do
      expect( Scrabble.score(nil) ).to eq 0
    end

    it "scores a word" do
      expect( Scrabble.score("hello") ).to eq 8
    end
  end

  describe ".highest_score_from" do
    it "picks the highest score" do
      expect( Scrabble.highest_score_from(['home', 'word', 'hello', 'sound']) ).to eq 'home'
    end

    it "picks the highest score from the fewest tiles" do
      expect( Scrabble.highest_score_from(['hello', 'word', 'sound']) ).to eq 'word'
    end

    it "picks the highest score that uses all seven letters" do
      expect( Scrabble.highest_score_from(['home', 'word', 'silence']) ).to eq 'silence'
    end

    it "picks the first one in supplied list in if the there are multiple words that are the same score and same length" do
      expect( Scrabble.highest_score_from(['hi', 'word', 'ward']) ).to eq 'word'
    end
  end
end

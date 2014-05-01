class Scrabble

LETTER_SCORE = {
  "A"=>1, "B"=>3, "C"=>3, "D"=>2,
  "E"=>1, "F"=>4, "G"=>2, "H"=>4,
  "I"=>1, "J"=>8, "K"=>5, "L"=>1,
  "M"=>3, "N"=>1, "O"=>1, "P"=>3,
  "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
  "U"=>1, "V"=>4, "W"=>4, "X"=>8,
  "Y"=>4, "Z"=>10
}

  def self.score(word)
    return 0 if word == nil
    return 0 if word.empty?
    score_word(word)
  end

  def self.highest_score_from(words)
    score_hash = words.inject({}) do |h, (word)|
      h[word] = score_word(word)
      h
    end
    sorted_score_hash = score_hash.sort_by { |k,v| v}
    highest_scoring_pair = sorted_score_hash.last
    highest_score = highest_scoring_pair.last
    highest_scoring_pair.first
  end

  private

  def self.score_word(word)
    formatted_word = word.upcase
    formatted_word.split("").inject(0) { |total,letter| total + LETTER_SCORE.fetch(letter) }
  end

end

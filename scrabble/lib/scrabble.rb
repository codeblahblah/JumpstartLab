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
    formatted_word = word.strip
    score_word(formatted_word)
  end

  def self.highest_score_from(words)
    score_array = build_score_array(words)

    highest_scoring_pair = score_array.last
    highest_scoring_word = highest_scoring_pair.first
    highest_scoring_score = highest_scoring_pair.last
    shortest_highest_scoring_pair = score_array.first
    shortest_highest_scoring_word = score_array.first.first

    highest_scoring_word.length == 7 ? highest_scoring_word : shortest_highest_scoring_word

  end

  private

  def self.score_word(word)
    formatted_word = word.upcase
    formatted_word.split("").inject(0) { |total,letter| total + LETTER_SCORE.fetch(letter) }
  end

  def self.build_score_array(words)
    score_hash = words.inject({}) do |h, (word)|
      h[word] = score_word(word)
      h
    end

    sorted_score_hash = sort_score_hash(score_hash)

    highest_score = sorted_score_hash.values.last
    sorted_score_hash.find_all { |k,v| v == highest_score}.sort_by { |k,v| k.length }
  end

  def self.sort_score_hash(score_hash)
    Hash[score_hash.sort_by { |k,v| v }]
  end
end

gem 'minitest'
require './lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'

class ScrabbleTest < Minitest::Test
  def test_it_can_score_a_single_letter
    assert_equal 1, Scrabble.score("a")
    assert_equal 4, Scrabble.score("f")
  end

  def test_it_can_score_an_empty_word
    assert_equal 0, Scrabble.score("")
  end

  def test_it_can_score_a_nil
    assert_equal 0, Scrabble.score(nil)
  end

  def test_it_can_score_a_word
    assert_equal 8, Scrabble.score("hello")
  end

  def test_it_can_high_score
    assert_equal 'home', Scrabble.highest_score_from(['home', 'word', 'hello', 'sound'])
  end

  def test_it_can_high_score_using_the_fewest_tiles
    assert_equal 'word', Scrabble.highest_score_from(['hello', 'word', 'sound'])
  end

  def test_it_can_high_score_using_all_seven_letters
    assert_equal 'silence', Scrabble.highest_score_from(['home', 'word', 'silence'])
  end

  def test_it_can_high_score_multiple_words_of_the_same_score_and_length
    assert_equal 'silence', Scrabble.highest_score_from(['home', 'word', 'silence'])
  end
end

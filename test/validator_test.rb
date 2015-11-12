require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/validator'

class ValidatorTest < MiniTest::Test
  include Validator

  def test_it_validates_hands_with_proper_formatting
    input = ('Ah As Ad Ac 8h')
    assert valid?(input), 'valid formatting'
  end

  def test_it_invalidates_hands_with_incorrect_formatting
    input = ("I'm not sure how this thing works.")
    refute valid?(input), 'invalid formatting'
  end

  def test_it_invalidates_hands_with_too_many_cards
    valid?("ah ad ac as 4h 4c")
    refute correct_number_of_cards?, 'too many cards'
  end

  def test_it_invalidates_hands_with_too_few_cards
    valid?("ah ad")
    refute correct_number_of_cards?, 'too few cards'
  end

  def test_it_invalidates_hands_with_duplicates
    valid?("ah ad as as 4h")
    refute no_duplicates?, 'duplicate cards'
  end

  def test_it_invalidates_hands_with_invalid_face_values
    valid?("60a ad as as 4h")
    refute no_duplicates?, 'invalid face value'
  end

  def test_it_invalidates_hands_with_invalid_suits
    valid?("6p ad as as 4h")
    refute no_duplicates?, 'invalid suit value'
  end

end

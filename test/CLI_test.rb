require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/CLI.rb'

class CLITest < MiniTest::Test

  def setup
    @cli = CLI.new
  end

  def test_it_validates_hands_with_proper_formatting
    input = ('Ah As Ad Ac 8h')
    assert @cli.send(:input_valid?, input), 'valid formatting'
  end

  def test_it_invalidates_hands_with_incorrect_formatting
    input = ("I'm not sure how this thing works.")
    refute @cli.send(:input_valid?, input), 'invalid formatting'
  end

  def test_it_invalidates_hands_with_too_many_cards
    @cli.send(:input_valid?, "ah ad ac as 4h 4c")
    refute @cli.send(:correct_number_of_cards?), 'too many cards'
  end

  def test_it_invalidates_hands_with_too_few_cards
    @cli.send(:input_valid?, "ah ad")
    refute @cli.send(:correct_number_of_cards?), 'too few cards'
  end

  def test_it_invalidates_hands_with_duplicates
    @cli.send(:input_valid?, "ah ad as as 4h")
    refute @cli.send(:no_duplicates?), 'duplicate cards'
  end

  def test_it_invalidates_hands_with_duplicates
    @cli.send(:input_valid?, "60a ad as as 4h")
    refute @cli.send(:no_duplicates?), 'invalid face value'
  end

  def test_it_invalidates_hands_with_invalid_face_values
    @cli.send(:input_valid?, "6p ad as as 4h")
    refute @cli.send(:no_duplicates?), 'invalid suit value'
  end

end

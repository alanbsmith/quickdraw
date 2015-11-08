require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/quickdraw.rb'

class QuickDrawTest < Minitest::Test

  def test_it_formats_the_cards_properly
    hand = Hand.new("Ah As 10c 7d 6s")
    assert_equal ["AH", "AS", "10C", "7D", "6S"], hand.cards
  end

  def test_it_knows_card_suits
    # Hearts, Clubs, Diamonds, Spades
    hand = Hand.new("Ah As 10c 7d 6s")
    assert_equal ["H","S","C","D","S"], hand.suits
  end

  def test_it_knows_card_face_values
    # 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace
    hand = Hand.new("Ah As 10c 7d Qs")
    assert_equal ["A","A","10","7","Q"], hand.faces
  end

  def test_it_knows_card_values
    # 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
    hand = Hand.new("Ah As 10c 7d Qs")
    assert_equal [14,14,10,7,12], hand.values
  end

  def test_it_can_evaluate_a_royal_flush
    # all same suit in sequential order (highest possible flush/hand)
    royal_flush = "10h Jh Qh Kh Ah"
    hand = Hand.new(royal_flush)
    assert_equal 'Royal Flush', hand.evaluate
  end

  def test_it_can_evaluate_a_straight_flush
    # all same suit in sequential order
    straight_flush = "5c 6c 7c 8c 9c"
    hand = Hand.new(straight_flush)
    assert_equal 'Straight Flush', hand.evaluate
  end

  def test_it_can_evaluate_four_of_a_kind
    # Same 4 faces
    four_of_a_kind = "Ah Ac Ad As 8h"
    hand = Hand.new(four_of_a_kind)
    assert_equal "Four of a Kind", hand.evaluate
  end

  def test_it_can_evaluate_a_full_house
    # 3 of a kind and 2 of a kind
    full_house = "Kh Kc Ks 9h 9c"
    hand = Hand.new(full_house)
    assert_equal "Full House", hand.evaluate
  end

  def test_it_can_evaluate_a_flush
    # all same suit
    flush = "Qc 8c 6c 4c 3c"
    hand = Hand.new(flush)
    assert_equal "Flush", hand.evaluate
  end

  def test_it_can_evaluate_a_straight
    # in sequential order
    straight = "2d 3c 4s 5d 6c"
    hand = Hand.new(straight)
    assert_equal "Straight", hand.evaluate
  end

  def test_it_can_evaluate_three_of_a_kind
    # Same 3 faces
    three_of_a_kind = "Jc Jh Jd 5c 8d"
    hand = Hand.new(three_of_a_kind)
    assert_equal "Three of a Kind", hand.evaluate
  end

  def test_it_can_evaluate_two_pair
    # 2 sets of 2 of a kind
    two_pair = "8d 8c 4d 6s 6c"
    hand = Hand.new(two_pair)
    assert_equal "Two Pair", hand.evaluate
  end

  def test_it_can_evaluate_one_pair
    # 2 of a kind
    one_pair = "Ah Ac 3h 8s 2d"
    hand = Hand.new(one_pair)
    assert_equal "One Pair", hand.evaluate
  end

  def test_it_can_evaluate_a_high_card
    # single high card
    high_card = "Kh Js 9c 6h 3d"
    hand = Hand.new(high_card)
    assert_equal "High Card", hand.evaluate
  end

end
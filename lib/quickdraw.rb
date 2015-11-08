# As a user I would like to have a way to determine my hand, so I can know how it ranks

# It needs to take some input( Ah As 10c 7d 6s ) and determines what I have (Pair of Aces)

# DIFFERENT TYPES OF HANDS
# - ROYAL FLUSH      10h Jh Qh Kh Ah  - all same suit
# - STRAIGHT FLUSH   5c 6c 7c 8c 9c   - all same suit in sequential order
# - FOUR OF A KIND   Ah Ac Ad As 8h   - Same 4 faces
# - FULL HOUSE       Kh Kc Ks 9h 9c   - 3 of a kind && 2 of a kind
# - FLUSH            Qc 8c 6c 4c 3c   - all same suit
# - STRAIGHT         2d 3c 4s 5d 6c   - in sequential order
# - THREE OF A KIND  Jc Jh Jd 5c 8d   - Same 3 faces
# - TWO PAIR         8d 8c 4d 6s 6c   - 2 sets of 2 of a kind
# - ONE PAIR         Ah Ac 3h 8s 2d   - 2 of a kind
# - HIGH CARD        Kh Js 9c 6h 3d   - single high card


class Hand
  attr_reader :cards, :suits, :faces, :values

  CARD_VALUES = { 
    "2" => 2, "3" => 3, "4" => 4,
    "5" => 5, "6" => 6, "7" => 7,
    "8" => 8, "9" => 9, "10" => 10,
    "J" => 11, "Q" => 12, "K" => 13,
    "A" => 14
  }

  def initialize(cards)
    @cards  = cards.upcase.split
    @suits  = get_suits
    @faces  = get_faces
    @values = get_values
  end

  def evaluate
    case
    when flush?
      determine_flush_type
    when straight?
      "Straight"
    when four_of_a_kind?
      "Four of a Kind"
    when full_house?
      "Full House"
    when three_of_a_kind?
      "Three of a Kind"
    when two_pair?
      "Two Pair"
    when one_pair?
      "One Pair"
    else
      "High Card"
    end
  end

  private

  def get_suits
    @cards.map { |card| card[-1] }
  end

  def get_faces
    @cards.map { |card| card.chomp(card[-1]) }
  end

  def get_values
    @faces.map { |face| CARD_VALUES[face] }
  end

  def flush?
    @suits.uniq.length == 1
  end

  def determine_flush_type
    if royal_flush?
      'Royal Flush'
    elsif straight?
      "Straight Flush"
    else
      "Flush"
    end
  end

  def royal_flush?
    @faces - ["A", "K","Q","J","10"] == []
  end

  def straight?
    @values.sort == (values[0]..values[4]).step.to_a
  end

  def four_of_a_kind?
    @faces.uniq.length == 2 && faces.any? { |face| faces.count(face) == 4  }
  end

  def full_house?
    @faces.uniq.length == 2 && faces.any? { |face| faces.count(face) == 3  }
  end

  def three_of_a_kind?
    @faces.uniq.length == 3 && faces.any? { |face| faces.count(face) == 3  }
  end

  def two_pair?
    @faces.uniq.length == 3 && faces.any? { |face| faces.count(face) == 2  }
  end

  def one_pair?
    @faces.uniq.length == 4
  end

end

# hand = Hand.new("Ah As 10s 7s 6s")
# p hand.cards
# p hand.suits
# p hand.faces

# hand.evaluate
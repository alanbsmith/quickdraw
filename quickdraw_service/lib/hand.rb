
class Hand
  attr_reader :cards, :suits, :faces, :values

  # Translation key for letters to suit names
  CARD_SUITS = {
    "S" => "Spades", "H" => "Hearts",
    "C" => "Clubs", "D" => "Diamonds"
  }

  # Translation key for numbers/letters to suit faces
  CARD_FACES = { 
    "2" => "2", "3" => "3", "4" => "4",
    "5" => "5", "6" => "6", "7" => "7",
    "8" => "8", "9" => "9", "10" => "10",
    "J" => "Jack", "Q" => "Queen", "K" => "King",
    "A" => "Ace"
  }

  # Translation key for numbers/suit faces to card values
  CARD_VALUES = {
    "2" => 2, "3" => 3, "4" => 4,
    "5" => 5, "6" => 6, "7" => 7,
    "8" => 8, "9" => 9, "10" => 10,
    "Jack" => 11, "Queen" => 12, "King" => 13,
    "Ace" => 14
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
      "Straight (#{straight})"
    when four_of_a_kind?
      "Four of a Kind (#{four_of_a_kind})"
    when full_house?
      "Full House (#{full_house})"
    when three_of_a_kind?
      "Three of a Kind (#{three_of_a_kind})"
    when two_pair?
      "Two Pair (#{two_pair})"
    when one_pair?
      "One Pair (#{one_pair})"
    else
      "High Card (#{high_card})"
    end
  end

  # private methods for internal calculation / evaluation
  private

  def get_suits
    @cards.map { |card| CARD_SUITS[card[-1]] }
  end

  def get_faces
    @cards.map { |card| CARD_FACES[card.chomp(card[-1])] }
  end

  def get_values
    @faces.map { |face| CARD_VALUES[face] }
  end

  def flush?
    @suits.uniq.length == 1
  end

  def determine_flush_type
    if royal_flush?
      "Royal Flush (#{royal_flush})"
    elsif straight?
      "Straight Flush (#{straight_flush})"
    else
      "Flush (#{flush})"
    end
  end

  def royal_flush?
    # determines the presence of a royal flush
    @faces - ["Ace","King","Queen","Jack","10"] == []
  end

  def royal_flush
    # displays formatted cards in the royal flush
    "#{@suits[0]}"
  end

  def straight_flush
    hash_array = @faces.map.with_index { |face, i| {'face' => face, 'value' => @values[i] } }
    sorted_faces = hash_array.sort_by { |key| key['value'] }.map { |key| key['face'] }
    # displays formatted cards in the straight flush
    "#{sorted_faces.join(",")} of #{@suits[0]}"
  end

  def flush
    # displays formatted cards in the flush
    "#{@faces.join(",")} of #{@suits[0]}"
  end

  def straight?
    # determines the presence of a straight
    sorted_values = @values.sort
    sorted_values == (sorted_values[0]..sorted_values[4]).step.to_a
  end

  def straight
    # displays formatted cards in the straight
    hash_array = @faces.map.with_index { |face, i| {'face' => face, 'value' => @values[i] } }
    sorted_faces = hash_array.sort_by { |key| key['value'] }.map { |key| key['face'] }
    "#{sorted_faces.join(",")}"
  end

  def four_of_a_kind?
    # determines the presence of four of a kind
    @faces.uniq.length == 2 && faces.any? { |face| faces.count(face) == 4  }
  end

  def four_of_a_kind
    # displays formatted cards in the four of a kind
    four_faces = @faces.select { |face| @faces.count(face) == 4 }.uniq.reduce
    "#{four_faces}s"
  end

  def full_house?
    # determines the presence of a full house
    @faces.uniq.length == 2 && faces.any? { |face| faces.count(face) == 3  }
  end

  def full_house
    # displays formatted cards in the full house
    house  = @faces.select { |face| @faces.count(face) == 3 }.uniq.reduce
    kicker = (@faces.uniq - house.split).reduce 
    "#{house}s full of #{kicker}s"
  end

  def three_of_a_kind?
    # determines the presence of three of a kind
    @faces.uniq.length == 3 && faces.any? { |face| faces.count(face) == 3  }
  end

  def three_of_a_kind
    # displays formatted cards in the three of a kind
    three_faces = @faces.select { |face| @faces.count(face) == 3 }.uniq.reduce
    "#{three_faces}s"
  end

  def two_pair?
    # determines the presence of two pairs
    @faces.uniq.length == 3 && faces.any? { |face| faces.count(face) == 2  }
  end

  def two_pair
    # displays formatted cards in the pairs
    two_faces = @faces.select { |face| @faces.count(face) == 2 }.uniq
    "#{two_faces[0]}s and #{two_faces[1]}s"
  end

  def one_pair?
    # determines the presence of a single pair
    @faces.uniq.length == 4
  end

  def one_pair
    # displays formatted cards in the pair
    pair = @faces.select { |face| @faces.count(face) == 2 }.uniq.reduce
    "#{pair}s"
  end

  def high_card
    # displays formatted high card
    high_card_index = @values.index(@values.max)
    "#{@faces[high_card_index]} of #{@suits[high_card_index]}"
  end

end

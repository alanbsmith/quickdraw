module Validator

  VALID_FACES = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]

  VALID_SUITS = ["H","S","D","C"]

  def valid?(input)
    @input = input
    correct_number_of_cards? && no_duplicates? && valid_faces? && valid_suits?
  end

  def correct_number_of_cards?
    @input.split.length == 5
  end

  def no_duplicates?
    @input.upcase.split.uniq.length == 5
  end

  def valid_faces?
    @input.upcase.split.all? {|card| VALID_FACES.include?(card.chomp(card[-1])) }
  end

  def valid_suits?
    @input.split.all? {|card| VALID_SUITS.include?(card[-1].upcase) }
  end

end
require_relative 'hand'
require_relative 'validator'

class CLI
  include Validator

  def run
    welcome
    main_menu
  end

  def welcome
    puts "Welcome to the QuickDraw CLI, your quick poker hand reference!"
  end

  def main_menu
    puts "\nMAIN MENU:"
    puts "You can (s)tart, get (i)nstructions, or (q)uit at any time."
    input = gets.chomp
    while input.chars[0] != 'q' do
      case input
      when 'i' || 'instructions'
        instructions
      when 's' || 'start'
        evaluate
        repeat_menu
      else
        puts "That's not a command I'm familiar with."
        main_menu
      end
    end
    quit
  end

  def instructions
    puts "\nINSTRUCTIONS:"
    puts "QuickDraw is designed to take a shorthand version of your 5 cards."
    puts "EXAMPLE: 'Ah 10d 6c 4s Qc' is Ace of Hearts, 10 of Diamonds, 4 of Spades, and Queen of Clubs"
    puts "\n
    ____________________________________________________________________________
    |                 |                                      |                 |
    |    HAND TYPE    |             DESCRIPTION              | EXAMPLE         |
    |-----------------|--------------------------------------|-----------------|
    | ROYAL FLUSH     | highest hand possible, all same suit | 10h Jh Qh Kh Ah |
    | STRAIGHT FLUSH  | all same suit in sequential order    | 5c 6c 7c 8c 9c  |
    | FOUR OF A KIND  | same 4 faces                         | Ah Ac Ad As 8h  |
    | FULL HOUSE      | 3 of a kind and 2 of a kind          | Kh Kc Ks 9h 9c  |
    | FLUSH           | all same suit                        | Qc 8c 6c 4c 3c  |
    | STRAIGHT        | in sequential order                  | 2d 3c 4s 5d 6c  |
    | THREE OF A KIND | Same 3 faces                         | Jc Jh Jd 5c 8d  |
    | TWO PAIR        | 2 sets of 2 of a kind                | 8d 8c 4d 6s 6c  |
    | ONE PAIR        | 2 of a kind                          | Ah Ac 3h 8s 2d  |
    | HIGH CARD       | single high cards                    | Kh Js 9c 6h 3d  |
    |_________________|______________________________________|_________________|
    \n
    "
    main_menu
  end

  def repeat_menu
    puts "Would you like to (t)ry another hand, get (i)nstructions, or (q)uit?"
    input = gets.chomp
    case input
    when 't' || 'try'
      evaluate
    when 'i' || 'instructions'
      instructions
    when 'q' || 'quit'
      quit
    else
     puts "That's not a command I'm familiar with."
     repeat_menu
    end
  end

  def evaluate
    puts "Please enter your five card hand."
    input = gets.chomp
    while input.chars[0] != 'q' do 
      if valid?(input)
        puts Hand.new(input).evaluate
        repeat_menu
      else
        try_again
      end
    end
    main_menu
  end

  def try_again
    puts "Invalid input. Would you like to (t)ry again or get (i)nstructions?"
    input = gets.chomp
    case input
    when 't' || 'try'
      evaluate
    when 'i' || 'instructions'
      instructions
    when 'q' || 'quit'
      quit
    end
  end

  def quit
    abort('Adios!')
  end

end

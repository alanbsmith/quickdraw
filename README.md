# QUICKDRAW

### OVERVIEW
QuickDraw is a poker hand evaluator built in Ruby! It's designed to use a special shorthand to make checking cards quick and easy.

**EXAMPLE SHORTHAND**
GIVEN THIS HAND OF CARDS:
King of hearts, Jack of spades, 9 of clubs, 10 of hearts, 3 of diamonds

THE CORRELATING SHORTHAND:
kh js 9c 10h 3d

### DIFFERENT TYPES OF POKER HANDS
Below are the various types of poker hands (ranked in order)

|HAND TYPE| DESCRIPTION | EXAMPLE |
|---------|-------------|---------|
|ROYAL FLUSH|        hightest hand possible, all same suit|  10 of hearts, Jack of hearts, Queen of hearts, King of hearts, Ace of hearts|
|STRAIGHT FLUSH|     all same suit in sequential order|      5 of clubs, 6 of clubs, 7 of clubs, 8 of clubs, 9 of clubs|
|FOUR OF A KIND|     Same 4 faces|                           Ace of hearts, Ace of clubs, Ace of diamonds, Ace of spades, 8 of hearts|
|FULL HOUSE|         3 of a kind and 2 of a kind|            King of hearts, King of clubs, King of spades, 9 of hearts, 9 of clubs|
|FLUSH|              all same suit|                          Queen of clubs, 8 of clubs, 6 of clubs, 4 of clubs, 3 of clubs|
|STRAIGHT|           in sequential order|                    2 of diamonds, 3 of clubs, 4 of spades, 5 of diamonds, 6 of clubs|
|THREE OF A KIND|    Same 3 faces|                           Jack of clubs, Jack of hearts, Jack of diamonds, 5 of clubs, 8 of diamonds|
|TWO PAIR|           2 sets of 2 of a kind|                  8 of diamonds, 8 of clubs, 4 of diamonds, 6 of spades, 6 of clubs|
|ONE PAIR|           2 of a kind|                            Ace of hearts, Ace of clubs, 3 of hearts, 8 of spades, 2 of diamonds|
|HIGH CARD|          single high card|                       King of hearts, Jack of spades, 9 of clubs, 6 of hearts, 3 of diamonds|

### UP & RUNNING
clone the repo and run `bundle install`

### USING THE CLI
The CLI is designed to explain and faciliate the use of QuickDraw. To get it up and running, simply run `ruby quickdraw.rb` from the root of this directory. In it you'll find explanations of various hands, and you can try out multiple hands to see the results.

### TESTING
The bulk of the tests tests are for `hand.rb`, where the majority of the logic lives. You'll probably notice that there are no 'sad path' tests for `hand.rb`. This is because `Hand` is just an internal receiving service, and therefore is only concerned with proper input. All validations are handled by the sending services (CLI) before `Hand` ever gets to them. This allows the CLI to be in charge of interacting with input and the internal service to be concerned with giving back the proper data. 

The CLI tests are focused on ensuring the hand input is valid and all corner cases are covered. There are no 'integration' tests for the CLI.

**RUNNING THE TESTS**
You can run `rake` from the root of this directory to run all the tests.


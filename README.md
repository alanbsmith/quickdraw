# QUICKDRAW

### OVERVIEW
QuickDraw is a poker hand evaluator built in Ruby! It's designed to use a special shorthand to make checking cards quick and easy.

**EXAMPLE SHORTHAND**

Given this hand of cards:

_King of hearts, Jack of spades, 9 of clubs, 10 of hearts, 3 of diamonds_

The correlating shorthand:

_kh js 9c 10h 3d_

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

### USING THE API
The API is a simple Sinatra controller with two endpoints: `api/v1/cards` and `api/v1/deal`. The `cards` endpoint takes params (e.g: 'ad ac ah as 4c') and returns a JSON object if the query is valid. If the request is not valid it will return 'Invalid Query'.

The `deal` endpoint returns a randomly generated hand and the value of the hand. This endpoint is used by the client-side React app.

This API is served by Rackup, so it runs on port: 9292. To fire up the API simply run `rackup`. This API also allows cross origin requests, so a client application could make AJAX requests to it.

### USING THE CLIENT APP
The client-side application for QuickDraw is written in React! It's main function is to make AJAX requests to the QuickDraw API, display random hands and the value.

To use the client app:
- hop in the `quickdraw-client` directory
- run `npm install`
- _be sure to run the separateSinatra API as well (see USING THE API above)_
- open your browser to 'localhost:8080'
- clicking 'DEAL ME' will generate a hand of five cards.

**EXAMPLE REQUEST TO THE 'CARDS' ENDPOINT:**
`localhost:9292/api/v1/cards?ah as ac ad 3s`

**EXAMPLE RESPONSE:**
```
{
  cards: [
    "Ace of Hearts",
    "Ace of Spades",
    "Ace of Clubs",
    "Ace of Diamonds",
    "3 of Spades"
  ],
  value: "Four of a Kind (Aces)"
}
```

### TESTING
The bulk of the tests tests are for `hand.rb`, where the majority of the logic lives. You'll probably notice that there are no 'sad path' tests for `hand.rb`. This is because `Hand` is just an internal receiving service, and therefore is only concerned with proper input. All validations are handled by the Validator module which is used by the sending services (CLI and the API). The data is validated before `Hand` ever gets to it. This allows the CLI and API to be in charge of interacting with input and allows the internal service to be concerned with giving back the proper data. 

The Validator tests are focused specifically on the module methods. The Validator is used by both the API and the CLI to ensure proper formatting before hitting the Hand service.

**RUNNING THE TESTS**

You can run `rake` from the root of this directory to run all the tests.


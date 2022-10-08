---
Project Title: War or Peace
Author: Nikhil Shahi
Date: October 8, 2022
Test Framework: RSpec
Test Coverage: 100%
---

Learning Goals
==============

- Follow an interaction pattern
- Write readable code that adheres to Ruby convention
- Write tests
- Create an Object Oriented Solution to a problem (objects should interact to achieve the stated goal)
- Host code on Github and submit a Pull Request

## Overview

In this project, we will write a program to simulate a game of war. A user will be able to create two players, and watch them ‘play’ the game.

In order to build good habits, we’ve broken the project into small classes to demonstrate objects that have a single responsibility.

## Iteration 1

### Cards

A Card represents a single card that would be in a traditional deck of 52 cards.

Use the tests provided to drive the development of your Card class. From the root directory of your project, run the test like this:

```rspec spec/card_spec.rb```

If your Card class is written properly and is located at ```./lib/card.rb```, you should be able to open a pry session from your ```war_or_peace``` directory and interact with it like so:

```ruby
# double check that you are in your war_or_peace project directory!
pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new(:heart, 'Jack', 11)
#=> #<Card:0x007fbda8a88348 @rank=11, @suit=:heart, @value="Jack">

pry(main)> card.suit
#=> :heart

pry(main)> card.value
#=> "Jack"

pry(main)> card.rank
#=> 11
```

### Deck

Create a ```Deck``` class and an accompanying test file with the following instance methods:

- ```initialize```: this method will take one argument - an array of cards.
- ```cards```: an attr_reader to read the @cards attribute
- ```rank_of_card_at```: this method will take one argument that represents the index location of a card to be used (typically 0 or 2 more on this later 😉 ) and will return the rank of that card.
- ```high_ranking_cards```: this method will return an array of cards in the deck that have a rank of 11 or above (face cards and aces)
- ```percent_high_ranking```: this method will return the percentage of cards that are high ranking
- ```remove_card```: this method will remove the top card from the deck
- ```add_card```: this method will add one card to the bottom (end) of the deck

Use the interaction pattern below to help you build your Deck test and Deck class.

Remember, ```#<Card:0x00randomletters&nums...>``` means “A Card Object” or “An Instance of the Card Class”. If you need to verify which card object it is, you can refer to the last few digits of the ‘random’ letters and numbers and match those to a card that is created near the top of the interaction pattern.

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> card1 = Card.new(:diamond, 'Queen', 12)
#=> #<Card:0x007fbfd18490e8...>

pry(main)> card2 = Card.new(:spade, '3', 3)    
#=> #<Card:0x007fbfd19f4fa0...>

pry(main)> card3 = Card.new(:heart, 'Ace', 14)    
#=> #<Card:0x007fbfd18555a0...>

pry(main)> cards = [card1, card2, card3]

pry(main)> deck = Deck.new(cards)
#=> #<Deck:0x007fbfd2984808 @cards=[#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]>

pry(main)> deck.cards
#=> [#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.rank_of_card_at(0)
#=> 12

pry(main)> deck.rank_of_card_at(2)
#=> 14

pry(main)> deck.cards
#=> [#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.high_ranking_cards
#=> [#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.percent_high_ranking
#=> 66.67

pry(main)> deck.remove_card
#=> #<Card:0x007fbfd18490e8 @rank=12, @suit=:diamond, @value="Queen">

pry(main)> deck.cards
#=> [#<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.high_ranking_cards
#=> [#<Card:0x007fbfd18555a0...>]

pry(main)> deck.percent_high_ranking
#=> 50.0

pry(main)> card4 = Card.new(:club, '5', 5)
#=> #<Card:0x007fbfd2963978 @rank=5, @suit=:club, @value="5">

pry(main)> deck.add_card(card4)

pry(main)> deck.cards
#=> [#<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>, #<Card:0x007fbfd2963978...>]

pry(main)> deck.high_ranking_cards
#=> [#<Card:0x007fbfd18555a0...>]

pry(main)> deck.percent_high_ranking
#=> 33.33
```

## Iteration 2

### Player

Create a ```Player``` class with accompanying tests. A ```Player``` is initialized with a deck, and can determine if they have lost the game.

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> require './lib/player'
#=> true

pry(main)> card1 = Card.new(:diamond, 'Queen', 12)
#=> #<Card:0x007f9cc3a73a98 @rank=12, @suit=:diamond, @value="Queen">

pry(main)> card2 = Card.new(:spade, '3', 3)    
#=> #<Card:0x007f9cc3a03720 @rank=3, @suit=:spade, @value="3">

pry(main)> card3 = Card.new(:heart, 'Ace', 14)    
#=> #<Card:0x007f9cc3a44c98 @rank=14, @suit=:heart, @value="Ace">

pry(main)> deck = Deck.new([card1, card2, card3])
#=> #<Deck:0x007f9cc396bdf8 @cards=[#<Card:0x007f9cc3a73a98...>, #<Card:0x007f9cc3a03720...>, #<Card:0x007f9cc3a44c98...>]>

pry(main)> player = Player.new('Clarisa', deck)
#=> #<Player:0x007f9cc3b4c988 @deck=#<Deck:0x007f9cc396bdf8 @cards=[#<Card:0x007f9cc3a73a98...>, #<Card:0x007f9cc3a03720...>, #<Card:0x007f9cc3a44c98...>]>, @name="Clarisa">

pry(main)> player.name
#=> "Clarisa"

pry(main)> player.deck
#=> #<Deck:0x007f9cc396bdf8 @cards=[#<Card:0x007f9cc3a73a98...>, #<Card:0x007f9cc3a03720...>, #<Card:0x007f9cc3a44c98...>]>

pry(main)> player.has_lost?
#=> false

pry(main)> player.deck.remove_card
#=> #<Card:0x007f9cc3a73a98 @rank=12, @suit=:diamond, @value="Queen">

pry(main)> player.has_lost?
#=> false

pry(main)> player.deck.remove_card
#=> #<Card:0x007f9cc3a03720 @rank=3, @suit=:spade, @value="3">

pry(main)> player.has_lost?
#=> false

pry(main)> player.deck.remove_card
#=> #<Card:0x007f9cc3a44c98 @rank=14, @suit=:heart, @value="Ace">

pry(main)> player.has_lost?
#=> true

pry(main)> player.deck
#=> #<Deck:0x007f9cc396bdf8 @cards=[]>
```

### Turn

The ```Turn``` is responsible for much of the logic of the game and will respond to the following methods:

- ```initialize```: A Turn is created with two players - player1 and player2
- readable attributes for ```player1```, ```player2```, and ```spoils_of_war```
- ```type```: a turn is ```:basic```, ```:war```, or ```:mutually_assured_destruction```
 - A ```:basic``` turn is one in which the ```rank_of_card_at(0)``` from the players’ decks are not the same rank.
 - A ```:war``` turn occurs when both players’ ```rank_of_card_at(0)``` are the same.
 - ```:mutually_assured_destruction``` occurs when both players’ ```rank_of_card_at(0)``` AND ```rank_of_card_at(2)``` are the same.
- ```winner```: this method will determine the winner of the turn
 - if the turn has a type of ```:basic```, it will return whichever ```player``` has a higher ```rank_of_card_at(0)```
 - if the turn has a type of ```:war``` the winner will be whichever ```player``` has a higher ```rank_of_card_at(2)```
 - if the turn has a type of ```:mutually_assured_destruction``` the method will return ```No Winner```.
- ```pile_cards```: when this method is called, cards will be sent from the players’ decks into the ```@spoils_of_war``` based on these rules
 - for a ```:basic``` turn, each player will send one card (the top card) to the ```spoils``` pile
 - for a ```:war``` turn, each player will send three cards (the top three cards) to the ```spoils``` pile
 - for a ```:mutually_assured_destruction``` turn, each player will remove three cards from play (the top three cards in their deck). These cards are not sent to the ```spoils``` pile, they are simply removed from each players’ deck.
- ```award_spoils```: this method will add each of the cards in the ```@spoils_of_war``` array to the ```winner``` of the turn.

The three interaction patterns below highlight the behavior of each type of turn.

```ruby
#turn type :basic
pry(main)> require './lib/card'
#=> true
pry(main)> require './lib/deck'
#=> true
pry(main)> require './lib/player'
#=> true
pry(main)> require './lib/turn'
#=> true

pry(main)> card1 = Card.new(:heart, 'Jack', 11)
#=> #<Card:0x007fa3edaa0df0 @rank=11, @suit=:heart, @value="Jack">
pry(main)> card2 = Card.new(:heart, '10', 10)    
#=> #<Card:0x007fa3eda519a8 @rank=10, @suit=:heart, @value="10">
pry(main)> card3 = Card.new(:heart, '9', 9)    
#=> #<Card:0x007fa3ed98d9b8 @rank=9, @suit=:heart, @value="9">
pry(main)> card4 = Card.new(:diamond, 'Jack', 11)    
#=> #<Card:0x007fa3ee14ef80 @rank=11, @suit=:diamond, @value="Jack">
pry(main)> card5 = Card.new(:heart, '8', 8)    
#=> #<Card:0x007fa3edb263d8 @rank=8, @suit=:heart, @value="8">
pry(main)> card6 = Card.new(:diamond, 'Queen', 12)    
#=> #<Card:0x007fa3eda3e1f0 @rank=12, @suit=:diamond, @value="Queen">
pry(main)> card7 = Card.new(:heart, '3', 3)    
#=> #<Card:0x007fa3edad1cc0 @rank=3, @suit=:heart, @value="3">
pry(main)> card8 = Card.new(:diamond, '2', 2)    
#=> #<Card:0x007fa3eda89308 @rank=2, @suit=:diamond, @value="2">

pry(main)> deck1 = Deck.new([card1, card2, card5, card8])    
#=> #<Deck:0x007fa3eda472c8 @cards=[#<Card:0x007fa3edaa0df0...>, #<Card:0x007fa3eda519a8...>, #<Card:0x007fa3edb263d8...>, #<Card:0x007fa3eda89308...>]>

pry(main)> deck2 = Deck.new([card3, card4, card6, card7])    
#=> #<Deck:0x007fa3ee11ee48 @cards=[#<Card:0x007fa3ed98d9b8...>, #<Card:0x007fa3ee14ef80...>, #<Card:0x007fa3eda3e1f0...>, #<Card:0x007fa3edad1cc0...>]>

pry(main)> player1 = Player.new("Megan", deck1)    
#=> #<Player:0x007fa3edae29d0 @deck=#<Deck:0x007fa3eda472c8...>, @name="Megan">

pry(main)> player2 = Player.new("Aurora", deck2)    
#=> #<Player:0x007fa3ed9e6568 @deck=#<Deck:0x007fa3ee11ee48...>, @name="Aurora">

pry(main)> turn = Turn.new(player1, player2)    
#=> #<Turn:0x007fa3edb25d20 @player1=#<Player:0x007fa3edae29d0..., @name="Megan">, @player2=#<Player:0x007fa3ed9e6568..., @name="Aurora">, @spoils_of_war=[]>

pry(main)> turn.player1
#=> #<Player:0x007fa3edae29d0 @deck=#<Deck:0x007fa3eda472c8...>, @name="Megan">

pry(main)> turn.player2
#=> #<Player:0x007fa3ed9e6568 @deck=#<Deck:0x007fa3ee11ee48...>, @name="Aurora">

pry(main)> turn.spoils_of_war
#=> []

pry(main)> turn.type
#=> :basic

pry(main)> winner = turn.winner
#=> #<Player:0x007fa3edae29d0 @deck=#<Deck:0x007fa3eda472c8...>, @name="Megan">

pry(main)> turn.pile_cards

pry(main)> turn.spoils_of_war
#=> [#<Card:0x007fa3edaa0df0 @rank=11, @suit=:heart, @value="Jack">, #<Card:0x007fa3ed98d9b8 @rank=9, @suit=:heart, @value="9">]

pry(main)> turn.award_spoils(winner)

pry(main)> player1.deck
#=> #<Deck:0x007fa3eda472c8 @cards=[#<Card:0x007fa3eda519a8...>, #<Card:0x007fa3edb263d8...>, #<Card:0x007fa3eda89308...>, #<Card:0x007fa3edaa0df0...>, #<Card:0x007fa3ed98d9b8...>]>
pry(main)> player2.deck
#=> #<Deck:0x007fa3ee11ee48 @cards=[#<Card:0x007fa3ee14ef80...>, #<Card:0x007fa3eda3e1f0...>, #<Card:0x007fa3edad1cc0...>]>
```

```ruby
# turn type :war
pry(main)> require './lib/card'
#=> true
pry(main)> require './lib/deck'
#=> true
pry(main)> require './lib/player'
#=> true
pry(main)> require './lib/turn'
#=> true

pry(main)> card1 = Card.new(:heart, 'Jack', 11)    
#=> #<Card:0x007fc42a170fe8 @rank=11, @suit=:heart, @value="Jack">
pry(main)> card2 = Card.new(:heart, '10', 10)    
#=> #<Card:0x007fc42a0f1b58 @rank=10, @suit=:heart, @value="10">
pry(main)> card3 = Card.new(:heart, '9', 9)    
#=> #<Card:0x007fc42aa85a98 @rank=9, @suit=:heart, @value="9">
pry(main)> card4 = Card.new(:diamond, 'Jack', 11)    
#=> #<Card:0x007fc42a205508 @rank=11, @suit=:diamond, @value="Jack">
pry(main)> card5 = Card.new(:heart, '8', 8)    
#=> #<Card:0x007fc42a2149e0 @rank=8, @suit=:heart, @value="8">
pry(main)> card6 = Card.new(:diamond, 'Queen', 12)    
#=> #<Card:0x007fc42a1e4790 @rank=12, @suit=:diamond, @value="Queen">
pry(main)> card7 = Card.new(:heart, '3', 3)    
#=> #<Card:0x007fc42a1b4c98 @rank=3, @suit=:heart, @value="3">
pry(main)> card8 = Card.new(:diamond, '2', 2)    
#=> #<Card:0x007fc42a1580d8 @rank=2, @suit=:diamond, @value="2">

pry(main)> deck1 = Deck.new([card1, card2, card5, card8])    
#=> #<Deck:0x007fc42a05a258 @cards=[#<Card:0x007fc42a170fe8...>, #<Card:0x007fc42a0f1b58...>, #<Card:0x007fc42a2149e0...>, #<Card:0x007fc42a1580d8...>]>

pry(main)> deck2 = Deck.new([card4, card3, card6, card7])    
#=> #<Deck:0x007fc42a248678 @cards=[#<Card:0x007fc42a205508...>, #<Card:0x007fc42aa85a98...>, #<Card:0x007fc42a1e4790...>, #<Card:0x007fc42a1b4c98...>]>

pry(main)> player1 = Player.new("Megan", deck1)    
#=> #<Player:0x007fc42a113000 @deck=#<Deck:0x007fc42a05a258...>, @name="Megan">

pry(main)> player2 = Player.new("Aurora", deck2)    
#=> #<Player:0x007fc42aab6b70 @deck=#<Deck:0x007fc42a248678...>, @name="Aurora">

pry(main)> turn = Turn.new(player1, player2)    
#=> #<Turn:0x007fc42a20d488 @player1=#<Player:0x007fc42a113000 @deck=#<Deck:0x007fc42a05a258...>, @name="Megan">, @player2=#<Player:0x007fc42aab6b70 @deck=#<Deck:0x007fc42a248678...>, @name="Aurora">, @spoils_of_war=[]>

pry(main)> turn.type
#=> :war

pry(main)> winner = turn.winner
#=> #<Player:0x007fc42aab6b70 @deck=#<Deck:0x007fc42a248678...>, @name="Aurora">

pry(main)> turn.pile_cards

pry(main)> turn.spoils_of_war
#=> [#<Card:0x007fc42a170fe8...>, #<Card:0x007fc42a0f1b58...>, #<Card:0x007fc42a2149e0...>, #<Card:0x007fc42a205508...>, #<Card:0x007fc42aa85a98...>, #<Card:0x007fc42a1e4790...>]

pry(main)> turn.award_spoils(winner)

pry(main)> player1.deck
#=> #<Deck:0x007fc42a05a258 @cards=[#<Card:0x007fc42a1580d8...>]>

pry(main)> player2.deck
#=> #<Deck:0x007fc42a248678 @cards=[#<Card:0x007fc42a1b4c98...>, #<Card:0x007fc42a170fe8...>, #<Card:0x007fc42a0f1b58...>, #<Card:0x007fc42a2149e0...>, #<Card:0x007fc42a205508...>, #<Card:0x007fc42aa85a98...>, #<Card:0x007fc42a1e4790...>]>
```

```ruby
# turn type :mutually_assured_destruction
pry(main)> require './lib/card'
#=> true
pry(main)> require './lib/deck'
#=> true
pry(main)> require './lib/player'
#=> true
pry(main)> require './lib/turn'
#=> true

pry(main)> card1 = Card.new(:heart, 'Jack', 11)    
#=> #<Card:0x007fadb0922f38 @rank=11, @suit=:heart, @value="Jack">
pry(main)> card2 = Card.new(:heart, '10', 10)    
#=> #<Card:0x007fadaf8c8458 @rank=10, @suit=:heart, @value="10">
pry(main)> card3 = Card.new(:heart, '9', 9)    
#=> #<Card:0x007fadaf9ab320 @rank=9, @suit=:heart, @value="9">
pry(main)> card4 = Card.new(:diamond, 'Jack', 11)    
#=> #<Card:0x007fadb1046fa8 @rank=11, @suit=:diamond, @value="Jack">
pry(main)> card5 = Card.new(:heart, '8', 8)    
#=> #<Card:0x007fadb0a247d8 @rank=8, @suit=:heart, @value="8">
pry(main)> card6 = Card.new(:diamond, '8', 8)    
#=> #<Card:0x007fadaf9e8e28 @rank=8, @suit=:diamond, @value="8">
pry(main)> card7 = Card.new(:heart, '3', 3)    
#=> #<Card:0x007fadaf130858 @rank=3, @suit=:heart, @value="3">
pry(main)> card8 = Card.new(:diamond, '2', 2)    
#=> #<Card:0x007fadaf96b180 @rank=2, @suit=:diamond, @value="2">

pry(main)> deck1 = Deck.new([card1, card2, card5, card8])    
#=> #<Deck:0x007fadaf94aae8 @cards=[#<Card:0x007fadb0922f38...>, #<Card:0x007fadaf8c8458...>, #<Card:0x007fadb0a247d8...>, #<Card:0x007fadaf96b180...>]>

pry(main)> deck2 = Deck.new([card4, card3, card6, card7])    
#=> #<Deck:0x007fadb1086f40 @cards=[#<Card:0x007fadb1046fa8...>, #<Card:0x007fadaf9ab320...>, #<Card:0x007fadaf9e8e28...>, #<Card:0x007fadaf130858...>]>

pry(main)> player1 = Player.new("Megan", deck1)    
#=> #<Player:0x007fadaf8b16e0 @deck=##<Deck:0x007fadaf94aae8 ...>, @name="Megan">

pry(main)> player2 = Player.new("Aurora", deck2)    
#=> #<Player:0x007fadb0a47800 @deck=#<Deck:0x007fadb1086f40 ...>, @name="Aurora">

pry(main)> turn = Turn.new(player1, player2)    
#=> #<Turn:0x007fadaf240fe0 @player1=#<Player:0x007fadaf8b16e0 @deck=##<Deck:0x007fadaf94aae8 ...>, @name="Megan">, @player2= #<Player:0x007fadb0a47800 @deck=#<Deck:0x007fadb1086f40 ...>, @name="Aurora">, @spoils_of_war=[]>

pry(main)> turn.type
#=> :mutually_assured_destruction

pry(main)> winner = turn.winner
#=> "No Winner"

pry(main)> turn.pile_cards

pry(main)> turn.spoils_of_war
#=> []
pry(main)> player1.deck
#=> #<Deck:0x007fadaf94aae8 @cards=[#<Card:0x007fadaf96b180...>]>
pry(main)> player2.deck
#=> #<Deck:0x007fadb1086f40 @cards=[#<Card:0x007fadaf130858...>]>
```

## Iteration 3

### Play the Game!

So far we’ve focused on modeling the data, classes, and methods that make up our game. However we haven’t done much in the way of setting up the game to be played. Now, we will tackle that problem.

A few key points to keep in mind as you work on this iteration:

- Use ```p``` to display a line of text output to the user
In this iteration we’ll introduce a new file called a “runner” – its job is to serve as the main entry point to our program by starting up a new game

First, create your runner file:

```
touch war_or_peace_runner.rb
```

Inside of this file, write the code to do the following:

- Create 52 Cards (A standard deck)
- Put those card into two Decks (some randomness would be nice here!)
- Create two players with the Decks you created
- Start the game using a new method called ```start```
- This method will need to be included in a class - it is up to you which class to include it in - either existing or ✨new

Keep in mind that your existing objects should still pass all existing tests - nothing that you add in this iteration should break anything that functioned in iterations 1 or 2!

When we start the game by running ```ruby war_or_peace_runner.rb```, it should produce the following interaction from the command line:

```
Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are Megan and Aurora.
Type 'GO' to start the game!
------------------------------------------------------------------
```

Then a user will be able to type ```GO```, and a game will start. The user will then see each turn being played, like this:

```
Turn 1: Megan won 2 cards
Turn 2: WAR - Aurora won 6 cards
Turn 3: *mutually assured destruction* 6 cards removed from play
...
...
...
Turn 9324: Aurora won 2 cards
*~*~*~* Aurora has won the game! *~*~*~*
```

The game continues until one player has all cards in play, at which point, that player is declared the winner of the game!

*Hint: take a look at the classes that you have built already, is there a method that will help you determine when the game has been won? or lost?*

In this game, there is the possibility of no winner. In order to cut down the amount of time it takes to play each game, and ensure that the game eventually does end, only 1,000,000 turns will be allowed. If no player has all cards after 1,000,000 turns, the result of the game is a draw.

```
Turn 1: Megan won 2 cards
Turn 2: WAR - Aurora won 6 cards
Turn 3: *mutually assured destruction* 6 cards removed from play
...
...
...
Turn 1000000: Aurora won 2 cards
---- DRAW ----
```

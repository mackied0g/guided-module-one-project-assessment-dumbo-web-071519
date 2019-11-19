Kitchen Stalker
========================

A basic Command Line Application. Users can create an account or login to an existing account. Filled with easter eggs and fun Bioshock quotes.

---

## To Get Started:
Feel free to fork and clone this project. To run this in your local terminal, you must have Ruby on your machine. 

Run the program by inputting:

```ruby bin/run.rb```

---

## What I learned for this project:

- Ruby
- Object Orientation
- Relationships (via ActiveRecord)
- Problem Solving (via creating a Command Line Interface (CLI))
- TTY-Prompt

## Project Overview (Walkthrough)

### Phase 1: Logging In vs. Creating New User:

User can Create a new account. If they have an account already, all they need to do is use their username. If the username doesn't exist, they're re-routed to create a new account.

Upon logging into an existing account, the user will see their wallet and will have items already stocked in their kitchen. 

Upon creating a new account, users will follow the storyline, where the user just moved out of their parents' house. The user's mother, as a sign of congratulations and gratitude, stocks the user's refrigerator with pre-selected items and automatically gives the user $200 for more groceries. 

### Phase 2: Main Menu Options:
Right away, the user is asked, "qu'est-ce que c'est?" In French, that means, "What's going on?" It's also a part of a song from one of my favorite bands, Talking Heads. The whole idea of calling it Kitchen Stalker/Kitchen Stocker, was to say "Kitchen Stalker, qu'est-ce que c'est? Fa-fa-fa-fa-fa-fa-fa-fa-fa-far better run run run run run run run awayyyyy!" There is an easter egg feature that turns this game into a very dark simulation, similar to another favorite game of mine, Doki Doki Literature Club. 

User has the opportunity to either:
- View fridge
- Go grocery shopping
- Go to work
- Exit game

#### View fridge:
User has sub-options here, they can either:
- View the fridge with no goal in mind, they just like to open the fridge and blankly stare at the contents before closing it all over again. (I do that all the time, and I wanted users to be able to do that, too.)
- Eat something (when they select an item, the item disappears from their fridge).
- Go grocery shopping, which brings them to the grocery store. (Also a tribute to another song, the user sees, "Macklemore, can we go grocery shopping?")

#### Go grocery shopping:
User has their wallet displayed so they can see what food items they can afford. Items are shown with a price next to them, and the user can scroll through the items. 
When selected, the user must confirm that they want to make that purchase. When purchased, it will be added to their refrigerator. Users can but multiple items, and multiples of the same items.

If the user doesn't have enough money for the item they selected, they have one of two choices:
- Put the item back and buy something else.
- Go to work to afford the item they want.

#### Go to work:
User can Update their wallet by $15 increments each time they "go to work." The app sleeps for a few seconds, then the users is prompted to take the money they've been given for their shift.

#### Exit game:
The game displays a [quote from my personal favorite game, Bioshock. Andrew Ryan says, "We all make choices, but in the end, our choices make us."](https://www.youtube.com/watch?v=P9DhpjRklgk) After that quote, the user is thanked for playing the game, and invited to come back to play again. The user is then logged out and the app finishes running. 


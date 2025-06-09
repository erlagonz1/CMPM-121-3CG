# CMPM-121-3CG

<h2>Programming Patterns:</h2>

I used various programming patterns to make this casual collectible card game. All of these programming patterns listed are found in our course textbook:

- Commands - I used these to implment grabbing and releasing of cards.
- Update method - I used this to check for state changes in game mangement file (board.lua), as changes can happen at any time.
- State - I used this to move between game states/phases. This allowed me to more easily implement logic for when the players are supposed to be staging cards, are battling, and for tracking if the game is complete.
- Subclass Sandbox - I used this to implement all of the cards. Specifically, I overrode the reveal function so that each card subclass had it's own implementation of reveal.

<h2>Peer Feedback:</h2>

The people who gave me feedback are Nathan Skinner, Cassian Jones, and Ayush Bandopadhyay, and Cassian Jones. In terms of suggestions, they gave similar feedback. They said that a key programming pattern that they used was the subclass sandbox pattern. I took this feedback and made sure that I used the pattern, which can be seen in the reveal functions of each card. They also said that an event queue would be nice as well, for all the staging/revealing of cards. They also suggested that I read in the card data from an external file. I wasn't able to figure this out before submitting the project, but it is something that I plan on implementing in the final project as an improvement. Other feedback they gave is that they think the code is very well organized and readible. They commented that my variable names, file names, and function names all make sense and have good structure.

<h2>Postmortem:</h2>

There are many improvements that I plan to make to the code. First, I want to implement functionality for reading in card data from an external file. I think that this would make my code a lot cleaner, and would cut down some lines in card.lua. I also want to implement some additional improvements. For example, I want to make sure that the card I am holding is always drawn on the highest layer of the program and isn't "under" anything. I also think the game would benefit from a title screen. In regards to programming patterns that would be beneficial to the code, It hink that the flyweight pattern would be a good fit for the card implementation. Mainly because many cards share the same cost and power, and they all share the same sprite for their backside. <br><br>
Something I did well is my code structure. I think I did a good job in regards to making my code readibly and visibly clean. I think my naming for the files, functions, and variables are all descriptive but not too lengthy as well. Overall, I like the functionality and readability of my project, but I hope to implement these changes for the revised version of this project.

<h2>Assets</h2>
- Sprites: I made all the sprites on piskel.com and photopea.com, which are free sprite editors. <br>
- Music: There is no background music. <br>
- SFX: There are no sound effects.

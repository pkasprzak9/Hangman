# Hangman Game

This repository contains a simple implementation of the Hangman game in Ruby. The game randomly selects a word from a dictionary file and prompts the player to guess letters until they either solve the word or run out of guesses.

## Features

- Word selection: The game selects a random word from a dictionary file containing 10,000 English words.
- Word length filtering: Only words with a length between 6 and 11 characters are considered for the game.
- Guessing letters: Players can guess individual letters to uncover them in the hidden word.
- Game over conditions: The game ends when the player has no more guesses left or when they correctly guess the entire word.
- Play again: After each game, players have the option to play again or exit the game.

## Usage

1. Make sure you have Ruby installed on your system.
2. Clone this repository to your local machine.
3. Navigate to the repository's directory.
4. Run the following command to start the game:
   ```
   ruby hangman.rb
   ```

## Dependencies

This Hangman game relies on the following dependencies:

- Ruby (at least version 3.2.2)
- CSV (Ruby standard library)

## Files

- `hangman.rb`: The main Ruby file containing the game logic.
- `dictionary.csv`: A CSV file containing a list of English words used for word selection.

## To-Do

- Implement game saving: Allow users to save the game at the beginning of each round. Use serialization to save the game progress.
- Load previous progress: At the beginning of the game, check if there is any previous progress saved. If so, load it and continue playing from the moment the game was saved.

## Contribution

Contributions to this Hangman repository are welcome! If you find any bugs, have suggestions for improvements, or want to add new features, feel free to submit a pull request.


## Acknowledgements

- The word list used in this game is sourced from https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt.

## Contributors
https://github.com/pkasprzak9

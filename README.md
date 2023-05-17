# Hangman

This is a simple implementation of the Hangman game in Ruby. The game randomly selects a word from a dictionary and challenges the player to guess the letters of the word within a limited number of guesses.

## Dependencies

This Hangman game relies on the following dependencies:

- Ruby (at least version 3.2.2)
- CSV (Ruby standard library)

## Installation and Usage

1. Clone or download the Hangman repository to your local machine.
2. Navigate to the Hangman directory.

### Game Instructions

1. Make sure you have the `dictionary.csv` file containing a list of English words.
2. Open a terminal or command prompt and navigate to the `Hangman` directory.
3. Run the following command to start the game:

   ```bash
   ruby main.rb
   ```

4. The game will prompt you to enter a letter as your guess. Enter a single letter and press Enter.
5. Continue guessing letters until you either guess the word correctly or run out of guesses.
6. If you want to save your progress and quit the game, enter `1` as your guess. You can later load the saved game when starting a new game.
7. After each game, you will be prompted to play again or quit.

## Implementation Details

- The game is implemented in the `Game` class, defined in the `main.rb` file.
- The `Game` class uses the `CSV` and `YAML` libraries to read from and write to files.
- The `correct_size` method filters the words in the dictionary based on their length, selecting only words between 6 and 11 characters long.
- The `choose_word` method randomly selects a word from the filtered dictionary and splits it into an array of characters.
- The `check_letter` method checks if a guessed letter is present in the word and updates the `guess_array` accordingly.
- The `game_over?` method checks if the game is over by determining if the player has no more guesses left or if the `guess_array` matches the word.
- The `check_win` method determines if the player has won or lost the game based on the `game_over?` condition and displays an appropriate message.
- The `play_again` method asks the player if they want to play another game and initiates a new game if the input is 'y'.
- The `save_game` method saves the game data to a YAML file for later retrieval.
- The `load_game` method loads the game data from the YAML file if it exists.
- The `ask_to_load_save` method asks the player if they want to load the previous game.
- The `clear_saved_game` method deletes the YAML file to clear the saved game.
- The `play_round` method handles a single round of the game, prompting the player for a guess, updating the `guess_array` and `used_letters`, and decrementing the number of remaining guesses.
- The `play` method sets up and runs a game round by choosing a word, initializing variables, calling `play_round`, and checking for a win or loss.
- The `initialize_game` method initializes the game variables.
- The `start_game` method opens the dictionary file, filters it for words of the correct size, and starts the game.

Have fun playing Hangman!

## Files

- `hangman.rb`: The main Ruby file containing the game logic.
- `dictionary.csv`: A CSV file containing a list of English words used for word selection.

## Contribution

Contributions to this Hangman repository are welcome! If you find any bugs, have suggestions for improvements, or want to add new features, feel free to submit a pull request.


## Acknowledgements

- The word list used in this game is sourced from https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt.

## Contributors
https://github.com/pkasprzak9

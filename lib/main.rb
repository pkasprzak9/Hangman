# frozen-string-literal: false

require 'csv'

# Checks and returns words from the dictionary that have a length between 6 and
# 11.
def correct_size(dictionary)
  dictionary_proper_length = []
  dictionary.each do |row|
    word = row[0]
    dictionary_proper_length << word if word.length > 5 && word.length < 12
  end
  dictionary_proper_length
end

# Randomly selects a word from the dictionary and splits it into an array of
# characters.
def choose_word(dictionary)
  dictionary.sample.split('')
end

# Checks each letter in the word and updates the guess_array with the guessed
# letter if it matches.
def check_letter(word, guess, guess_array)
  word.each_with_index do |letter, index|
    guess_array[index] = " #{letter} " if letter == guess
  end
  puts guess_array.join('')
end

# Checks if the game is over by determining if the player has no more guesses
# left or if the guess_array matches the word.
def game_over?(guesses_left, guess_array, word)
  guesses_left.zero? || word.join == guess_array.join.gsub(' ', '')
end

# Checks if the player has won or lost the game based on the game_over?
# condition.
def check_win(guesses_left, guess_array, word)
  if game_over?(guesses_left, guess_array, word) && guesses_left.positive?
    puts 'You won!'
  else
    puts 'You lose.'
    puts "The word was: #{word.join}"
  end
end

# Asks the player if they want to play again and initiates another game if the # input is 'y'.
def play_again(file)
  puts 'Would you like to play again? (y/n)'
  input = gets.chomp until input == 'y' || input == 'n'
  case input
  when 'y'
    play(file)
  when 'n'
    puts 'Thanks for playing!'
  end
end

# Handles a single round of the game, prompting the player for a guess and
# updating the guess_array and used_letters accordingly.
def play_round(guesses_left, guess_array, word, used_letters)
  until game_over?(guesses_left, guess_array, word)
    puts "Already guessed letters:  #{used_letters.join('')}"
    guess = ''
    puts "#{guesses_left} guesses left"
    puts 'Enter your guess: '
    guess = gets.chomp.to_s until guess.length == 1
    check_letter(word, guess, guess_array)
    used_letters << "#{guess} " unless used_letters.include?("#{guess} ")
    guesses_left -= 1
  end
end

# Sets up and runs a game round by choosing a word, initializing variables, and # calling play_round and check_win.
def play(file)
  word = choose_word(file)
  puts "Your word is: #{word.length} letters long"
  guess_array = Array.new(word.length) { ' _ ' }
  used_letters = []
  @guesses_left = 9
  play_round(@guesses_left, guess_array, word, used_letters)
  check_win(@guesses_left, guess_array, word)
  play_again(file)
end

# Opens the dictionary file, filters it for words of correct size, and starts
# the game.
def start_game
  file = CSV.open('dictionary.csv')
  file = correct_size(file)
  play(file)
end

start_game

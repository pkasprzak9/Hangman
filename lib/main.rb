# frozen-string-literal: false

require 'csv'
require 'yaml'

class Game
  SAVE_FILE = 'saved_game.yaml'.freeze

  def initialize
    @word = []
    @guess_array = []
    @used_letters = []
    @guesses_left = 9
  end

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
  def game_over?
    @guesses_left.zero? || @word.join == @guess_array.join.gsub(' ', '')
  end

  # Checks if the player has won or lost the game based on the game_over?
  # condition.
  def check_win
    if game_over? && @guesses_left.positive?
      puts 'You won!'
      clear_saved_game
    elsif !game_over? && @guesses_left.positive?
      puts 'Your progress has been saved!'
    else
      puts 'You lose.'
      puts "The word was: #{@word.join}"
      clear_saved_game
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

  # Saves the game data to the YAML file
  def save_game
    game_data = {
      'word' => @word,
      'guessed_letters' => @guess_array,
      'used_letters' => @used_letters,
      'guesses_left' => @guesses_left
    }
    File.open(SAVE_FILE, 'w') do |file|
      file.write(game_data.to_yaml)
    end
    puts 'Game saved.'
  end

  # Loads the game data from the YAML file
  def load_game
    return unless File.exist?(SAVE_FILE)

    game_data = YAML.load_file(SAVE_FILE)
    @word = game_data['word']
    @guess_array = game_data['guessed_letters']
    @used_letters = game_data['used_letters']
    @guesses_left = game_data['guesses_left']
  end

  # Ask player if they want to load the save
  def ask_to_load_save
    answer = false
    puts 'Do you want to load the previous game? (y/n)'
    input = gets.chomp
    answer = true if input == 'y'
    answer
  end

  # Clears the saved game by deleting the YAML file if it exists
  def clear_saved_game
    File.delete(SAVE_FILE) if File.exist?(SAVE_FILE)
  end

  # Handles a single round of the game, prompting the player for a guess and
  # updating the guess_array and used_letters accordingly.
  def play_round
    until game_over?
      puts "Already guessed letters:  #{@used_letters.join('')}"
      guess = ''
      puts "#{@guesses_left} guesses left"
      puts 'Enter your guess (enter 1 to save game and quit): '
      guess = gets.chomp.to_s until guess.length == 1
      if guess == '1'
        save_game
        break
      else
        check_letter(@word, guess, @guess_array)
        @used_letters << "#{guess} " unless @used_letters.include?("#{guess} ")
        @guesses_left -= 1
      end
    end
  end

  # Sets up and runs a game round by choosing a word, initializing variables, and # calling play_round and check_win.
  def play(file)
    if File.exist?(SAVE_FILE)
      if ask_to_load_save
        load_game
      else
        @word = choose_word(file)
        @guess_array = Array.new(@word.length) { ' _ ' }
        @used_letters = []
        @guesses_left = 9
      end
    else
      @word = choose_word(file)
      @guess_array = Array.new(@word.length) { ' _ ' }
      @used_letters = []
      @guesses_left = 9
    end
    puts "Your word is: #{@word.length} letters long"
    play_round
    check_win
    play_again(file)
  end

  # Opens the dictionary file, filters it for words of correct size, and starts
  # the game.
  def start_game
    file = CSV.open('dictionary.csv')
    file = correct_size(file)
    play(file)
  end
end

game = Game.new
game.start_game

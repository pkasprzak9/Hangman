# frozen-string-literal: false

require 'csv'

def correct_size(dictionary)
  dictionary_proper_length = []
  dictionary.each do |row|
    word = row[0]
    dictionary_proper_length << word if word.length > 5 && word.length < 12
  end
  dictionary_proper_length
end

def choose_word(dictionary)
  correct_size(dictionary).sample.split('')
end

def guess_letter(word, guess_array, used_letters, guesses_left)
  puts "Already guessed letters:  #{used_letters.join('')}"
  guess = ''
  puts "#{guesses_left} guesses left"
  puts 'Enter your guess: '
  guess = gets.chomp.to_s until guess.length == 1
  check_letter(word, guess, guess_array)
  used_letters << "#{guess} "
end

def check_letter(word, guess, guess_array)
  word.each_with_index do |letter, index|
    guess_array[index] = " #{letter} " if letter == guess
  end
  puts guess_array.join('')
end

def play_game
  file = CSV.open('dictionary.csv')
  word = choose_word(file)
  puts "Your word is: #{word.length} letters long"
  guesses_left = 9
  guess_array = Array.new(word.length) { ' _ ' }
  used_letters = []
  puts guess_array.join('')
  guess_letter(word, guess_array, used_letters, guesses_left) && guesses_left -= 1 until guesses_left.zero?
end

play_game

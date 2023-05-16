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
  correct_size(dictionary).sample
end

def guess
  guesses_left = 9
  until guesses_left.zero?
    guess = ''
    puts "#{guesses_left} guesses left"
    guesses_left -= 1
    puts 'Enter your guess: '
    guess = gets.chomp.to_s until guess.length == 1
  end
end

def play_game
  file = CSV.open('dictionary.csv')
  word = choose_word(file).split('')
  puts "Your word is: #{word.length} letters long"
  guess
end

play_game

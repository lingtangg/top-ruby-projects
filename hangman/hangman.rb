module Hangman
  TURNS = 10
end

class Game
  def initialize(human_class)
    @human = human_class.new
  end

  def choose_word()
    # choose word between 5 and 12 chars
    chosen_word = 'test'
    while chosen_word.length < 5 || chosen_word.length > 12
      chosen_word = File.readlines("google-10000-english/google-10000-english-no-swears.txt", 'r').map(&:chomp).sample
    end
    chosen_word
  end

  def check_guess(guess, word)
    word.include?(guess)
  end

  def indices_of_matches(str, target)
    sz = target.size
    (0..str.size-sz).select {|i| str[i,sz] == target}
  end

  def play()
    word = choose_word()
    hangman_game = Array.new(word.size, "_")
    guessed_letters = []
    turn = 0

    until hangman_game.join == word || turn > TURNS
      # ability to save and end game

      puts "Word: #{hangman_game.join}"
      puts "Guessed letters: #{guessed_letters.join(', ')}"
      guess = @human.guess_letter(guessed_letters)
      if word.include?(guess)
        # find indices of the letter
        appearances = indices_of_matches(word, guess)
        # replace the game array with the letters
        appearances.each do |appearance|
          hangman_game[appearance] = guess
        end
      else
        puts "#{guess} is not in the word"
      end
      turn += 1
      puts "You have #{turn} turns left"
    end
    if hangman_game.join == word
      puts "You have guessed the word!"
      puts "#{word}"
    end
    if turn > TURNS
      puts "You have run out of turns"
      puts "The word was #{word}"
    end
  end
end

class Player
  def initalize(game)
    @game = game
  end
end

class HumanPlayer < Player
  def verify_guess(guess, guessed_letters)
    guessed_letters.include?(guess)
  end

  def guess_letter(guessed_letters) # play will include the array of guessed letters
    # ask user to guess letter
    unguessed_letter = true
    while unguessed_letter == true
      puts "What letter do you guess?"
      user_guess = gets.chomp.downcase
      if verify_guess(user_guess, guessed_letters)
        puts "You have already guessed this letter"
      else
        guessed_letters.push(user_guess)
        unguessed_letter = false
      end
    end
    user_guess
  end

end

include Hangman

Game.new(HumanPlayer).play
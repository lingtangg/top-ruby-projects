module Mastermind
  COLOURS = ["red", "blue", "yellow", "green", "purple", "orange"]
  RESPONSE = {:correct => 'x', :wrong_spot => 'o'}
  TURNS = 12

class Game
  def initialize(human_class, computer_class)
    # creates players based on the Player classes
    @human = human_class.new(self)
    @computer = computer_class.new(self)
  end

  def play()
    # play until all x or turns > 12
    correct_combo = @computer.starting_combo()
    mastermind = false
    until mastermind == true
      guess = @human.guess_combo()
      check = @computer.check_user_combo(guess, correct_combo)
      if check.class == Array
        puts check
      else
        mastermind == true
      end
    end
  end
end

class Player
  def initialize(game)
    @game = game
  end
end

class HumanPlayer < Player
  def verify_guess(guess, remaining_colours)
    # verify player's guess is in the (remaining) colours array
    remaining_colours.include?(guess)
  end

  def guess_combo()
    remaining_colours = COLOURS
    guess = []
    verified = false
    # ask user for choice 4 times
    4.times do
      # ensure user input is a valid ccolour
      while verified = false
        puts "Choose from the following colours: #{remaining_colours.inspect}"
        user_guess = gets.chomp.downcase
        if verify_guess(user_guess, remaining_colours)
          guess.push(user_guess)
          remaining_colours.delete(user_guess)
          verified = true
        else
          puts "#{user_guess} is not a valid option"
        end
      end
    end
    # print user's guess
    puts "Your guess:"
    guess.each do |x|
      puts "x"
    end
    guess
  end
end

class ComputerPlayer < Player
  def starting_combo()
    # choose 4 random colours
    chosen_array = COLOURS.sample(4)
    chosen_array
  end

  def check_user_combo(user_combo, correct_combo)
    answer_array = []
    # check if correct colour and spot
    if user_combo == correct_combo
      puts "You are the mastermind!"
      return true
    else
      # creates nested arrays of pairs 
      comp_combo = correct_combo.zip(user_combo)
      comp_combo.each do |guess|
        # check if correct colour and spot
        if guess[0] == guess[1]
          answer_array.push(RESPONSE[:correct])
        else
          # otherwise check if the user's guess is in the correct combo but wrong spot
          if correct_combo.include?(guess[1]) then answer_array.push(RESPONSE[:wrong_spot]) end
        end
      end
      answer_array
    end
  end
end
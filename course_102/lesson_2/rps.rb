require 'pry'

class Move
  include Comparable
  attr_reader :choice

  def initialize(choice)
    @choice = choice
  end

  def <=>(opponent)
    if choice == opponent.choice
      0
    elsif (choice == 'R'  && opponent.choice == 'S')  ||
          (choice == 'R'  && opponent.choice == 'L')  ||
          (choice == 'P'  && opponent.choice == 'R')  ||
          (choice == 'P'  && opponent.choice == 'SP') ||
          (choice == 'S'  && opponent.choice == 'P')  ||
          (choice == 'S'  && opponent.choice == 'L')  ||
          (choice == 'L'  && opponent.choice == 'P')  ||
          (choice == 'L'  && opponent.choice == 'SP') ||
          (choice == 'SP' && opponent.choice == 'S')  ||
          (choice == 'SP' && opponent.choice == 'R')
      1
    else
      -1
    end
  end
end

class Players
  CHOICES = { 'R' => "Rock", 'P' => "Paper", 'S' => "Scissors",
              'L' => "Lizard", 'SP' => "Spock" }
  attr_accessor :name, :move

  def to_s
    "#{name} threw #{CHOICES[move.choice]}"
  end
end

class Human < Players
  def initialize
    set_name
  end

  def set_name
    Game.display_msg(:name)
    name = gets.chomp.capitalize
    while name.empty?
      Game.display_msg(:name_error)
      name = gets.chomp.capitalize
    end
    self.name = name
  end

  def turn
    Game.display_msg(:choice)
    move = gets.chomp.upcase
    while CHOICES.keys.none? { |choice| choice == move }
      Game.display_msg(:choice_error)
      move = gets.chomp.upcase
    end
    self.move = Move.new(move)
  end
end

class Computer < Players
  STAR_WAR_NAMES = ['R2-D2', 'BB-8', 'C-3P0']

  def initialize
    self.name = STAR_WAR_NAMES.sample
  end

  def turn
    self.move = Move.new(CHOICES.keys.sample)
  end
end

class Game
  MESSAGES = {
    choice:       "\nSHOOT! (R)ock / (P)aper / (S)cissors / (L)izard / (SP)ock):",
    choice_error: "\nSelect either (R)ock, (P)aper, (S)cissors, (L)izard, or (SP)ock",
    goodbye:      "\nThanks for playing Rock, Paper, Scissors, Lizard, Spock!",
    name:         "\nWhat's your name?",
    name_error:   "Name can't be blank:",
    play_again:   "\nPlay again? (Y/N):",
    tie:          "\nIt's a tie!",
    welcome:      "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  }

  attr_reader :human, :computer

  def initialize
    clear_screen
    Game.display_msg(:welcome)
    @human = Human.new
    @computer = Computer.new
  end

  def play
    loop do
      display_rules
      display_intro_animation
      human.turn
      computer.turn
      display_moves
      display_results(determine_winner)
      break if play_again? == 'N'
    end
    Game.display_msg(:goodbye)
  end

  def display_rules
    clear_screen
    puts <<-RULES.gsub(/^\s*\|/, '')
      |-------GAME RULES--------
      |Rock      >>    Scissors
      |Rock      >>    Lizard
      |Paper     >>    Rock
      |Paper     >>    Spock
      |Scissors  >>    Paper
      |Scissors  >>    Lizard
      |Lizard    >>    Spock
      |Lizard    >>    Paper
      |Spock     >>    Scissors
      |Spock     >>    Rock
      |
      |Feel good and ready #{human.name}? Press enter to play!
    RULES
    gets.chomp
  end

  def display_intro_animation
    clear_screen
    puts "Rock......."
    sleep 0.5
    puts "Paper......"
    sleep 0.5
    puts "Scissors..."
    sleep 0.5
    puts "Lizard....."
    sleep 0.5
    puts "Spock......"
    sleep 0.5
  end

  def display_moves
    clear_screen
    puts human
    puts computer
  end

  def display_results(winner)
    case winner
    when :tie   then Game.display_msg(:tie)
    when :human then puts "\n#{human.name.upcase} YOU WIN!"
    else puts "\n#{computer.name} wins. You lose."
    end
  end

  def determine_winner
    case
    when human.move == computer.move then :tie
    when human.move > computer.move then :human
    else :computer
    end
  end

  def play_again?
    Game.display_msg(:play_again)
    play_again = gets.chomp.upcase
    while %w(Y N).none? { |char| char == play_again }
      Game.display_msg(:play_again)
      play_again = gets.chomp.upcase
    end
    play_again
  end

  def clear_screen
    (system 'clear') || (system 'cls')
  end

  def self.display_msg(msg_key)
    puts "#{MESSAGES[msg_key]}"
  end
end

Game.new.play

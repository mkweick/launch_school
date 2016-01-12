require 'colorize'

class Players
  attr_reader :name, :color, :letter
  attr_accessor :wins

  def winner?(board)
    Board::WINNING_LINES.any? do |line|
      board.tiles.values_at(*line).map(&:value)
        .count(letter.colorize(color)) == 3
    end
  end
end

class Human < Players
  HUMAN_COLORS = { '1' => :light_green, '2' => :light_blue,
                   '3' => :light_magenta, '4' => :light_cyan }

  def initialize
    @name = human_name
    @letter = human_letter
    @color = human_color
    @wins = 0
  end

  def human_name
    puts
    puts "What's your name partner?"
    name = gets.chomp.capitalize
    while name.empty?
      puts "Name cannot be empty:"
      name = gets.chomp.capitalize
    end
    name
  end

  def human_letter
    puts
    puts "Okay #{name}, would you like to play as X's or O's? (X/O)"
    letter = gets.chomp.upcase
    until %w(X O).include? letter
      puts "Selection must either be X or O"
      letter = gets.chomp.upcase
    end
    letter
  end

  def human_color
    display_color_msg
    color_key = gets.chomp
    until HUMAN_COLORS.keys.include? color_key
      puts "Color selection must be 1 - 4"
      color_key = gets.chomp
    end
    HUMAN_COLORS[color_key]
  end

  def display_color_msg
    puts
    puts "#{name} you are #{letter}'s. What color would you like to be? "\
         "(Computer is #{'Red'.colorize(:light_red)})"
    puts " 1 -- #{'Green'.colorize(:light_green)}"
    puts " 2 -- #{'Blue'.colorize(:light_blue)}"
    puts " 3 -- #{'Magenta'.colorize(:light_magenta)}"
    puts " 4 -- #{'Cyan'.colorize(:light_cyan)}"
    puts
  end

  def move(board)
    puts "#{name}'s".colorize(color) + " Turn:"
    tile_picked = gets.chomp
    until board.open_tiles.include? tile_picked
      puts
      puts "Open tiles left:  #{board.open_tiles.join(' | ')}"
      tile_picked = gets.chomp
    end
    board.tiles[(tile_picked.to_i - 1)].value = letter.colorize(color)
  end
end

class Computer < Players
  STAR_WARS = ['R2-D2', 'BB-8', 'C-3PO']

  def initialize(human_letter)
    @name = STAR_WARS.sample
    @letter = computer_letter(human_letter)
    @color = :light_red
    @wins = 0
  end

  def computer_letter(human_letter)
    human_letter == 'X' ? 'O' : 'X'
  end

  def move(board, human_letter, human_color)
    # first check if computer can win
    if board.two_in_row?(letter, color)
      smart_move(board, letter, color)
    # then check if player can win and block
    elsif board.two_in_row?(human_letter, human_color)
      smart_move(board, human_letter, human_color)
    else
      random_move(board)
    end
  end

  def smart_move(board, ltr, col)
    smart_tiles = board.get_smart_tiles(ltr, col)
    board.tiles[(smart_tiles.sample.to_i - 1)].value = letter.colorize(color)
  end

  def random_move(board)
    board.tiles[(board.open_tiles.sample.to_i - 1)].value = letter.colorize(color)
  end
end

class Board
  WINNING_LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                   [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  VALID_TILES = %w(1 2 3 4 5 6 7 8 9)

  attr_reader :tiles

  def initialize
    @tiles = []
    9.times { |n| @tiles << Tile.new((n + 1).to_s) }
  end

  def print_board
    Game.clear_screen
    puts
    puts " #{tiles[0].value} #{'|'.colorize(:light_yellow)}"\
         " #{tiles[1].value} #{'|'.colorize(:light_yellow)}"\
         " #{tiles[2].value} "
    puts "---+---+---".colorize(:light_yellow)
    puts " #{tiles[3].value} #{'|'.colorize(:light_yellow)}"\
         " #{tiles[4].value} #{'|'.colorize(:light_yellow)}"\
         " #{tiles[5].value} "
    puts "---+---+---".colorize(:light_yellow)
    puts " #{tiles[6].value} #{'|'.colorize(:light_yellow)}"\
         " #{tiles[7].value} #{'|'.colorize(:light_yellow)}"\
         " #{tiles[8].value} "
    puts
  end

  def open_tiles
    tiles.map { |tile| tile.value if VALID_TILES.include? tile.value }.compact
  end

  def two_in_row?(letter, color)
    WINNING_LINES.any? do |line|
      line_contains_two?(line, letter, color) &&
        line_contains_open_tile?(line)
    end
  end

  def line_contains_two?(line, letter, color)
    tiles.values_at(*line).map(&:value).count(letter.colorize(color)) == 2
  end

  def line_contains_open_tile?(line)
    tiles.values_at(*line).map(&:value).any? { |value| VALID_TILES.include? value }
  end

  def get_smart_tiles(letter, color)
    smart_tiles = []
    WINNING_LINES.any? do |line|
      if line_contains_two?(line, letter, color) && line_contains_open_tile?(line)
        tiles.values_at(*line).each do |tile|
          if VALID_TILES.include? tile.value
            smart_tiles << tile.value
          end
        end
      end
    end
    smart_tiles
  end

  def winner?
    WINNING_LINES.any? do |line|
      line.map { |value| tiles[value].value }.uniq.count == 1
    end
  end

  def full?
    !tiles.any? { |tile| VALID_TILES.include? tile.value }
  end
end

class Tile
  attr_accessor :value

  def initialize(num)
    @value = num
  end
end

class Game
  attr_reader :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new(human.letter)
    Game.clear_screen
    display_intro
  end

  def display_intro
    puts "#{human.name.colorize(human.color)}  vs  "\
         "#{computer.name.colorize(computer.color)}"
    puts
    puts "First to 5 wins is the champion!"
    puts
    count = 3
    while count > 0
      puts "#{count}"
      sleep 2
      count -= 1
    end
  end

  def print_result(board)
    if human.winner?(board)
      puts "#{human.name.upcase} YOU WON!".colorize(human.color)
    elsif computer.winner?(board)
      puts "#{computer.name.colorize(computer.color)} won. You lost."
    else
      puts "Tie Game!"
    end
  end

  def update_series_wins(board)
    human.wins += 1 if human.winner?(board)
    computer.wins += 1 if computer.winner?(board)
  end

  def print_series_score
    puts
    puts "_____Series Score_____"
    puts "#{human.name} (#{human.wins})   ".colorize(human.color) +
      "#{computer.name} (#{computer.wins})".colorize(computer.color)
  end

  def print_series_winner
    if human.wins == 5
      puts
      puts "#{human.name.upcase} YOU ARE THE CHAMPION!!!!!".colorize(human.color)
    else
      puts
      puts "#{computer.name} has prevailed as champ.".colorize(computer.color)
    end
  end

  def next_round?
    puts
    puts "Enter any key to start next round. (enter 'Q' to quit series)"
    gets.chomp.upcase
  end

  def series_winner?
    human.wins == 5 || computer.wins == 5
  end

  def reset_wins
    human.wins = 0
    computer.wins = 0
  end

  def play_again?
    puts
    puts "Play again? (Y/N)"
    play_again = gets.chomp.upcase
    until %w(Y N).include? play_again
      puts "'Y' to play again or 'N' to exit."
      play_again = gets.chomp.upcase
    end
    play_again
  end

  def play_ttt
    loop do
      loop do
        board = Board.new
        Game.clear_screen
        board.print_board
        play_round(board)
        print_result(board)
        update_series_wins(board)
        print_series_score
        print_series_winner if series_winner?
        break if series_winner? || next_round? == 'Q'
      end
      reset_wins
      break if play_again? == 'N'
    end
  end

  def play_round(board)
    loop do
      break if board.winner? || board.full?
      human.move(board)
      board.print_board
      break if board.winner? || board.full?
      computer.move(board, human.letter, human.color)
      board.print_board
    end
  end

  def self.welcome_msg
    puts "Welcome to #{'Tic'.colorize(:light_green)}, "\
         "#{'Tac'.colorize(:light_cyan)}, #{'Toe!'.colorize(:light_magenta)}"
  end

  def self.goodbye_msg
    puts
    puts "Thanks for playing #{'Tic'.colorize(:light_green)}, "\
         "#{'Tac'.colorize(:light_cyan)}, "\
         "#{'Toe!'.colorize(:light_magenta)} Goodbye!"
    puts
  end

  def self.clear_screen
    system 'clear'
  end
end

Game.clear_screen
Game.welcome_msg
Game.new.play_ttt
Game.goodbye_msg

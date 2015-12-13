CHOICES = { 'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors',
            'l' => 'Lizard', 'sp' => 'Spock' }

def prompt(msg)
  puts "==> #{msg}"
end

def display_game_intro
  prompt "Rock......."
  sleep 0.5
  prompt "Paper......"
  sleep 0.5
  prompt "Scissors..."
  sleep 0.5
  prompt "Lizard....."
  sleep 0.5
  prompt "Spock......"
  sleep 0.5
  puts
end

def determine_winner(player, computer, name)
  case player
  when 'r' then (computer == 's' || computer == 'l') ? name : 'computer'
  when 'p' then (computer == 'r' || computer == 'sp') ? name : 'computer'
  when 's' then (computer == 'p' || computer == 'l') ? name : 'computer'
  when 'l' then (computer == 'p' || computer == 'sp') ? name : 'computer'
  else (computer == 'r' || computer == 's') ? name : 'computer'
  end
end

def game_winner?(player_wins, computer_wins)
  player_wins == 5 || computer_wins == 5
end

def display_game_winner(name, player_wins)
  if player_wins == 5
    prompt "#{name.upcase} WINS THE GAME!!!!!!!!!"
  else
    prompt "COMPUTER WINS THE GAME."
  end
end

prompt "Welcome to Rock, Paper, Scissors!"
prompt "What's your name?"
player_name = gets.chomp.capitalize
until player_name =~ /\A[a-zA-Z]+\z/
  prompt "Name can only contain letters"
  player_name = gets.chomp.capitalize
end

puts
prompt "First to win 5 rounds, wins the game!"
sleep 1
puts
total_player_wins = 0
total_computer_wins = 0

loop do
  display_game_intro

  prompt <<-MSG
What do you throw?
    'r'  for rock
    'p'  for paper
    's'  for scissors
    'l'  for lizard
    'sp' for spock
  MSG

  player_choice = gets.chomp.downcase
  until CHOICES.keys.include? player_choice
    prompt "Invalid selection. Must be #{CHOICES.keys.join(', ')}"
    player_choice = gets.chomp.downcase
  end

  computer_choice = CHOICES.keys.sample
  prompt "You threw #{CHOICES[player_choice]}. " \
         "Computer threw #{CHOICES[computer_choice]}"
  sleep 1

  if player_choice == computer_choice
    winner = 'nobody'
  else
    winner = determine_winner(player_choice, computer_choice, player_name)
  end

  total_player_wins += 1 if winner == player_name
  total_computer_wins += 1 if winner == 'computer'

  prompt(winner == 'nobody' ? "IT'S A TIE" : "#{winner.upcase} WINS")
  sleep 1
  puts

  prompt "  Player Wins: #{total_player_wins}"
  prompt "Computer Wins: #{total_computer_wins}"
  puts

  if game_winner?(total_player_wins, total_computer_wins)
    display_game_winner(player_name, total_player_wins)
    sleep 1
    puts
  end

  prompt "Play again? 'y' or 'n'"
  play_again = gets.chomp.downcase
  until %w(y n).include? play_again
    prompt "'y' to play again or 'n' to quit"
    play_again = gets.chomp.downcase
  end

  break if play_again == 'n'

  if game_winner?(total_player_wins, total_computer_wins)
    prompt "Resetting game values..."
    sleep 1
    puts
    total_player_wins = 0
    total_computer_wins = 0
  end
end

prompt "Thanks for playing Rock, Paper, Scissors, Lizard, Spock."
prompt "Goodbye #{player_name}!"

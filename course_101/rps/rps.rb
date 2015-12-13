CHOICES = { 'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors' }

def prompt(msg)
  puts "==> #{msg}"
end

def determine_winner(player_value, computer_value, player_name)
  case player_value
  when 'r' then computer_value == 's' ? player_name : 'computer'
  when 'p' then computer_value == 'r' ? player_name : 'computer'
  else computer_value == 'p' ? player_name : 'computer'
  end
end

prompt "Welcome to Rock, Paper, Scissors!"
prompt "What's your name?"
player_name = gets.chomp.capitalize
until player_name =~ /\A[a-zA-Z]+\z/
  prompt "Name can only contain letters"
  player_name = gets.chomp.capitalize
end

total_player_wins = 0
total_computer_wins = 0

loop do
  prompt "Rock......."
  sleep 1
  prompt "Paper......"
  sleep 1
  prompt "Scissors..."
  sleep 1

  prompt <<-MSG
What do you throw?
    'r' for rock
    'p' for paper
    's' for scissors
  MSG

  player_choice = gets.chomp.downcase
  until CHOICES.keys.include? player_choice
    prompt "Invalid selection. Must either be 'r', 'p' or 's'"
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

  prompt "Play again? 'y' or 'n'"
  play_again = gets.chomp.downcase
  until %w(y n).include? play_again
    prompt "'y' to play again or 'n' to quit"
    play_again = gets.chomp.downcase
  end

  break if play_again == 'n'
end

prompt "Thanks for playing Rock, Paper, Scissors. Goodbye #{player_name}!"

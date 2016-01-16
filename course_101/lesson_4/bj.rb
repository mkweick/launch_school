class Deck
  CARD_VALUES = { "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
                  "8" => 8, "9" => 9, "10" => 10, "J" => 10, "Q" => 10,
                  "K" => 10, "A" => 11 }
  CARDS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(♥ ♦ ♠ ♣)

  attr_reader :deck_count
  attr_accessor :cards

  def initialize
    @cards = []
    @deck_count = num_decks
    build_deck
    shuffle
  end

  def num_decks
    Game.display_msg(:deck_count)
    num = gets.chomp.to_i
    until num >= Game::MIN_DECK_COUNT
      Game.display_msg(:deck_count_error)
      num = gets.chomp.to_i
    end
    num
  end

  def build_deck
    deck_count.times do
      SUITS.each do |suit|
        CARDS.each do |card|
          cards << card + suit
        end
      end
    end
  end

  def deal
    reshuffle if deck_empty?
    cards.shift
  end

  def deck_empty?
    cards.count < 1
  end

  def shuffle
    display_shuffle_animation
    cards.shuffle!
  end

  def reshuffle
    build_deck
    shuffle
  end

  def display_shuffle_animation
    system 'clear'
    print "Shuffling Cards...."
    6.times do
      sleep 0.5
      print "...."
    end
  end
end

class Player
  attr_accessor :name, :hand

  def initialize
    @name = player_name
    @hand = []
  end

  def player_name
    Game.display_msg(:player_name)
    name = gets.chomp.capitalize
    while name.empty?
      Game.display_msg(:player_name_error)
      name = gets.chomp.capitalize
    end
    name
  end

  def to_s
    "\n#{name.capitalize}:\n  #{hand.join("\n  ")}\nTotal = #{total}"
  end

  def hit_or_stay
    Game.display_msg(:hit_or_stay)
    action = gets.chomp.upcase
    until %w(H S).include? action
      Game.display_msg(:hit_or_stay)
      action = gets.chomp.upcase
    end
    action
  end

  def deal_card(deck)
    hand << deck.deal
  end

  def total
    total = 0
    hand.each { |card| total += Deck::CARD_VALUES[card.chop] }
    if total > Game::BLACKJACK
      aces = hand.select { |card| card.chop == 'A' }
      aces.each do
        total -= 10
        break if total <= Game::BLACKJACK
      end
    end
    total
  end

  def bust?
    total > Game::BLACKJACK
  end

  def blackjack?
    total == Game::BLACKJACK
  end
end

class Dealer < Player
  def initialize
    @name = "Dealer"
    @hand = []
  end

  def hide_dealer_card
    puts "\n#{name}:\n  #{hand.first}\n  ??"
  end
end

class Game
  BLACKJACK = 21
  MUST_STAY_NUM = 17
  MIN_DECK_COUNT = 3
  MESSAGES = {
    deck_count:         "\nHow many decks in this game? (Minimum of 3):",
    deck_count_error:   "\nMust play with a minimum of #{MIN_DECK_COUNT} decks:",
    deal_again:         "\nDeal again? (Y) or (N):",
    dealer_blackjack:   "\nYOU LOST. Dealer has Blackjack.",
    dealer_bust:        "\nYOU WON! Dealer Busted!",
    dealer_get_card:    "\nDealer is getting another card...",
    dealer_high_score:  "\nYOU LOST. Dealer has higher score.",
    goodbye:            "\nThanks for playing Blackjack partner!",
    hit_or_stay:        "\n(H)it or (S)tay?",
    player_blackjack:   "\nYOU WON! You have Blackjack!",
    player_bust:        "\nYOU LOST. You Busted!",
    player_high_score:  "\nYOU WON! You have higher score!",
    player_name:        "\nWhats your name?",
    player_name_error:  "Name can't be empty:",
    tie_blackjack:      "\nTIE! Both have Blackjack.",
    tie_score:          "\nTIE! Both have equal score.",
    welcome:            "\nWelcome to Blackjack Partner"
  }

  attr_reader :player, :dealer, :deck
  attr_accessor :dealer_flag

  def initialize
    clear_screen
    Game.display_msg(:welcome)
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @dealer_flag = false
  end

  def self.display_msg(msg_key)
    puts "#{MESSAGES[msg_key]}"
  end

  def display_result
    if player.bust?
      Game.display_msg(:player_bust)
    elsif dealer.bust?
      Game.display_msg(:dealer_bust)
    elsif player.blackjack? && dealer.blackjack?
      Game.display_msg(:tie_blackjack)
    elsif player.blackjack?
      Game.display_msg(:player_blackjack)
    elsif dealer.blackjack?
      Game.display_msg(:dealer_blackjack)
    elsif player.total == dealer.total
      Game.display_msg(:tie_score)
    elsif player.total > dealer.total
      Game.display_msg(:player_high_score)
    else
      Game.display_msg(:dealer_high_score)
    end
  end

  def play
    loop do
      initial_deal
      show_cards
      player_turn
      show_cards
      unless player.bust?
        dealer_turn
        show_cards
      end
      display_result
      clear_hands
      break if deal_again? == 'N'
    end
    Game.display_msg(:goodbye)
    puts "\nGoodbye #{player.name}!"
  end

  def initial_deal
    self.dealer_flag = false
    2.times do
      player.deal_card(deck)
      dealer.deal_card(deck)
    end
  end

  def show_cards
    clear_screen
    dealer_flag ? (puts dealer) : (dealer.hide_dealer_card)
    puts player
  end

  def player_turn
    until player.blackjack? || player.bust?
      action = player.hit_or_stay
      player.deal_card(deck) if action == 'H'
      clear_screen
      show_cards
      break if action == 'S'
    end
  end

  def dealer_turn
    self.dealer_flag = true
    show_cards
    until dealer.total >= MUST_STAY_NUM
      Game.display_msg(:dealer_get_card)
      sleep 1.5
      dealer.deal_card(deck)
      clear_screen
      show_cards
    end
  end

  def clear_hands
    player.hand.clear
    dealer.hand.clear
  end

  def deal_again?
    Game.display_msg(:deal_again)
    deal_again = gets.chomp.upcase
    until %w(Y N).include? deal_again
      Game.display_msg(:deal_again)
      deal_again = gets.chomp.upcase
    end
    deal_again
  end

  def clear_screen
    system 'clear'
  end
end

Game.new.play

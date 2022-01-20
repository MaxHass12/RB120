require 'yaml'
MESSAGES = YAML.load_file('messages.yml')

module UIMethods
  def prompt(message)
    puts "=> #{message}"
  end

  def press_enter_to_continue
    loop do
      prompt(MESSAGES['enter_to_continue'])
      choice = gets.chomp
      break if choice == ""
      prompt(MESSAGES['invalid_input'])
    end
  end

  def clear_screen
    system("clear")
  end

  def display_welcome_message
    clear_screen
    prompt(MESSAGES['welcome'])
    prompt(MESSAGES['blank'])
    prompt(MESSAGES['rules'])
    prompt(MESSAGES['blank'])
    press_enter_to_continue
  end

  def joinand(arr, separator=', ', word='and')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(separator)
    end
  end

  def player_choice
    choice = nil
    loop do
      prompt(MESSAGES['blank'])
      prompt(MESSAGES['hit_or_stay'])
      choice = gets.chomp.downcase
      break if ['h', 's'].include?(choice)
      prompt(MESSAGES['invalid_input'])
    end
    choice == 'h' ? :hit : :stay
  end

  def display_goodbye_message
    prompt(MESSAGES['blank'])
    prompt(MESSAGES['bye'])
  end

  def play_again?
    choice = nil
    loop do
      prompt(MESSAGES['blank'])
      prompt(MESSAGES['play_again'])
      choice = gets.chomp.downcase
      break if ['y', 'n'].include?(choice)
      prompt(MESSAGES['invalid_input'])
    end
    choice == 'y'
  end
end

class Participant
  include UIMethods

  def initialize
    @hand = nil
  end

  def reset_hand
    @hand = []
  end

  def busted?
    hand_value > 21
  end

  def add_to_hand(card)
    @hand << card
  end

  def hand_value
    total = 0
    @hand.each do |card| # adding value for non-Ace cards
      total += card.value if (1..10).include?(card.value)
      total += 10 if ['Jack', 'Queen', 'King'].include?(card.value)
    end
    @hand.each do |card| # adding value of Ace depending on the total value
      total += total + 11 <= 21 ? 11 : 1 if card.value == "Ace"
    end
    total
  end

  private

  def hit(deck)
    @hand << deck.deal_card
  end
end

class Player < Participant
  attr_reader :stays

  def initialize
    super
    @stays = false
  end

  def take_turn(deck)
    choice = player_choice
    if choice == :hit
      hit(deck)
    elsif choice == :stay
      self.stays = true
    end
  end

  def display_hand
    cards = @hand.map(&:to_s)
    prompt("You have: #{joinand(cards)}.")
  end

  private

  attr_writer :stays
end

class Dealer < Participant
  DEALER_HIT_THRESHOLD = 17

  def initialize
    super
    @has_turn = false
  end

  def display_hand(player_stay)
    cards = @hand.map(&:to_s)
    if player_stay
      prompt("Dealer has: #{joinand(cards)}.")
    else
      prompt("Dealer has: #{cards.first} and an Unknown Card.")
    end
  end

  def take_turn(deck)
    loop do
      break if hand_value >= DEALER_HIT_THRESHOLD
      hit(deck)
      break if busted?
    end
  end
end

class Deck
  include UIMethods

  SUITS = ['Heart', 'Diamond', 'Club', 'Spade']
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'King', 'Queen', 'Ace']

  def initialize
    @cards = nil
  end

  def reset_cards
    @cards = []
    SUITS.product(VALUES).shuffle.each do |arr|
      @cards << Card.new(arr.first, arr.last)
    end
  end

  def deal_card
    @cards.pop
  end
end

class Card
  attr_reader :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "'#{value} of #{suit}'"
  end

  private

  attr_reader :suit
end

class Game
  include UIMethods

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    display_welcome_message
    loop do
      pre_game_setup
      player_take_turn
      dealer_take_turn unless player.busted?
      display_result
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_reader :deck, :player, :dealer

  def pre_game_setup
    deck.reset_cards
    player.reset_hand
    dealer.reset_hand
    deal_hands
  end

  def deal_hands
    2.times do
      player.add_to_hand(deck.deal_card)
      dealer.add_to_hand(deck.deal_card)
    end
  end

  def display_hands
    clear_screen
    dealer.display_hand(player.stays)
    prompt(MESSAGES['blank'])
    player.display_hand
  end

  def player_take_turn
    loop do
      display_hands
      player.take_turn(deck)
      break if player.busted? || player.stays
    end
  end

  def dealer_take_turn
    prompt(MESSAGES['blank'])
    prompt("You chose to stay.")
    prompt(MESSAGES['blank'])
    prompt("Dealer's turn...")
    prompt(MESSAGES['blank'])
    sleep(1)
    dealer.take_turn(deck)
  end

  def display_result
    display_hands
    if player.busted?
      show_player_busted
    elsif dealer.busted?
      show_dealer_busted
    else
      show_winner
    end
  end

  def show_values
    prompt(MESSAGES['blank'])
    prompt("Your Hand Value: #{player.hand_value}")
    prompt("Dealer's Hand Value: #{dealer.hand_value}")
  end

  def show_winner
    prompt(MESSAGES['blank'])
    if dealer.hand_value < player.hand_value
      prompt("You Win.")
    elsif dealer.hand_value > player.hand_value
      prompt("You Lose.")
    else
      prompt("Its a draw.")
    end
    show_values
  end

  def show_player_busted
    prompt(MESSAGES['blank'])
    prompt(MESSAGES['you_bust'])
    prompt(MESSAGES['blank'])
    prompt("Your hand's value: #{player.hand_value}")
  end

  def show_dealer_busted
    prompt(MESSAGES['blank'])
    prompt(MESSAGES['dealer_bust'])
    show_values
  end
end

Game.new.play

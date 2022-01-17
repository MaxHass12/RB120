require 'yaml'
MESSAGES = YAML.load_file('rps_bonus_features_messages.yml')

module Constants
  MOVES = { 'r' => "Rock",
            'p' => "Paper",
            's' => "Scissors",
            'sp' => "Spock",
            'l' => "Lizard" }

  WINNING_COMB = {
    "Rock" => ["Lizard", "Scissors"],
    "Lizard" => ["Spock", "Paper"],
    "Spock" => ["Rock", "Scissors"],
    "Scissors" => ["Lizard", "Paper"],
    "Paper" => ["Rock", "Spock"]
  }

  MAX_WINS = 3

  def prompt(msg)
    puts "=> " + msg.to_s
  end
end

class Move
  include Constants

  def initialize(value)
    @name = value
  end

  def >(other)
    WINNING_COMB[name].include?(other.name)
  end

  def to_s
    name
  end

  protected

  attr_reader :name
end

class Player
  include Constants

  attr_reader :choice

  def initialize
    @name = set_name
    @choice = nil
    @score = 0
    @past_moves = []
  end

  def display_choice
    prompt("#{name} : #{choice}")
  end

  def wins
    self.score = score + 1
    "#{name} wins"
  end

  def display_score
    prompt("#{name} : #{score}")
  end

  def max_won?
    score >= MAX_WINS
  end

  def reset_score
    self.score = 0
  end

  def show_features
    prompt(" ")
    prompt("You are playing against #{name}.")
    prompt(" ")
  end

  def show_history
    prompt("#{name}'s move history (latest move at the end) : ")
    prompt(past_moves)
  end

  private

  attr_writer :choice
  attr_accessor :name, :score, :past_moves

  def append(move)
    past_moves << move.to_s
  end
end

class Human < Player
  def choose_move
    input = nil
    system("clear")
    loop do
      prompt(MESSAGES['choose_move'])
      input = gets.chomp.downcase
      break if MOVES.include?(input)
      prompt(MESSAGES['invalid_input'])
    end
    self.choice = Move.new(MOVES[input])
    append(choice)
  end

  def prompt_for_history
    prompt("Enter 'u' for #{name}'s move history")
  end

  def welcome
    prompt("Welcome #{name}.")
  end

  private

  def set_name
    input = nil
    loop do
      prompt(MESSAGES['name'])
      input = gets.chomp
      break unless input.delete(" ") == ""
      prompt(MESSAGES['invalid_input'])
    end
    self.name = input.capitalize
  end
end

class Computer < Player
  def prompt_for_history
    prompt("Enter 'c' for #{name}'s move history")
  end
end

class MacBook < Computer
  def show_features
    super
    prompt(MESSAGES['macbook_features'])
  end

  def choose_move
    random_choice = if [true, false].sample
                      MOVES.values.first
                    else
                      MOVES.values[1..-1].sample
                    end
    self.choice = Move.new(random_choice)
    append(choice)
  end

  private

  def set_name
    "MacBook"
  end
end

class Windows < Computer
  def show_features
    super
    prompt(MESSAGES['windows_features'])
  end

  def choose_move
    random_choice = if [true, false].sample
                      MOVES.values.last
                    else
                      MOVES.values[0..-2].sample
                    end
    self.choice = Move.new(random_choice)
    append(choice)
  end

  def prompt_for_history
    prompt("Enter 'c' for #{name}'s move history")
  end

  private

  def set_name
    "Windows"
  end
end

class RPSGameConsole
  include Constants

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = random_computer
    show_details
  end

  def play
    loop do
      reset_scores
      loop do
        play_single_round
        break if game_over?
      end
      display_ultimate_winner
      break unless play_another_game?
    end
    display_goodbye_message
  end

  private

  attr_reader :human, :computer

  def play_single_round
    human.choose_move
    computer.choose_move
    display_choices
    display_winner
    display_score
    see_move_history
  end

  def display_welcome_message
    system("clear")
    prompt(MESSAGES['welcome'])
    prompt(MESSAGES['line'])
    display_rules
    prompt(MESSAGES['line'])
  end

  def display_choices
    system("clear")
    prompt("Choices")
    prompt(" ")
    human.display_choice
    computer.display_choice
  end

  def display_winner
    prompt(" ")
    if human.choice > computer.choice
      prompt("#{human.wins} the current round.")
    elsif computer.choice > human.choice
      prompt("#{computer.wins} the current round.")
    else
      prompt("Its a draw")
    end
  end

  def display_score
    prompt(" ")
    prompt("Current Scores: ")
    prompt(" ")
    human.display_score
    computer.display_score
    continue?
  end

  def game_over?
    human.max_won? || computer.max_won?
  end

  def display_ultimate_winner
    ultimate_winner = human.max_won? ? human : computer
    prompt(MESSAGES['line'])
    prompt("Game Over! #{ultimate_winner.wins} the game.")
    prompt(MESSAGES['line'])
  end

  def display_rules
    MESSAGES['rules'].each { |rule| prompt(rule) }
    prompt(" ")
    prompt("First to win #{MAX_WINS} rounds wins the game.")
  end

  def random_computer
    [true, false].sample ? MacBook.new : Windows.new
  end

  def show_details
    system("clear")
    human.welcome
    computer.show_features
    continue?
  end

  def continue?
    prompt(" ")
    loop do
      prompt(MESSAGES['continue'])
      input = gets.chomp
      break if input == ""
      prompt(MESSAGES['invalid_input'])
    end
  end

  def play_another_game?
    prompt(" ")
    input = nil
    loop do
      prompt(MESSAGES['another_game'])
      prompt(MESSAGES['yes_or_no'])
      input = gets.chomp.downcase
      break if ['y', 'n'].include?(input)
      prompt(MESSAGES['invalid_input'])
    end
    input == 'y'
  end

  def reset_scores
    human.reset_score
    computer.reset_score
  end

  def display_goodbye_message
    prompt(MESSAGES['line'])
    prompt(MESSAGES['bye'])
  end

  def show_move_history(input)
    player = input == 'c' ? computer : human
    player.show_history
    continue?
  end

  def game_history_input
    human.prompt_for_history
    computer.prompt_for_history
    prompt("Or " + MESSAGES['continue'])
  end

  def see_move_history
    input = nil
    loop do
      game_history_input
      input = gets.chomp.downcase
      return if input == ""
      break if ['c', 'u'].include?(input)
      prompt(MESSAGES['invalid_input'])
    end
    show_move_history(input)
  end
end

game = RPSGameConsole.new
game.play

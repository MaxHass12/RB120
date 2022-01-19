require 'yaml'
MESSAGES = YAML.load_file("messages.yml")

module UIMethods
  def clear_screen
    system("clear")
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def press_enter_to_continue
    loop do
      prompt(MESSAGES['enter_to_continue'])
      choice = gets.chomp
      break if choice == ''
      prompt(MESSAGES['invalid_input'])
    end
  end

  def display_welcome_message
    clear_screen
    prompt(MESSAGES['welcome'])
    prompt(" ")
    press_enter_to_continue
  end

  def display_goodbye_message
    prompt(MESSAGES['goodbye'])
  end

  def play_again?
    choice = nil
    loop do
      prompt(" ")
      prompt(MESSAGES['play_again'])
      choice = gets.chomp.downcase
      break if ['y', 'n'].include?(choice)
      prompt(MESSAGES['invalid_input'])
    end
    choice == 'y'
  end

  def joinor(arr, separator=', ', word='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(separator)
    end
  end

  def input_user_name
    input = nil
    loop do
      prompt(MESSAGES['enter_name'])
      input = gets.chomp
      break unless input.delete(" ") == ""
      prompt(MESSAGES['invalid_input'])
    end
    input
  end

  def input_user_marker
    input = nil
    loop do
      prompt(MESSAGES['enter_marker'])
      prompt(" ")
      input = gets.chomp
      break unless input.downcase == 'o' || input == " " || input.size > 1
      prompt(MESSAGES['invalid_input'])
    end
    input
  end

  def user_input_first_player
    input = nil
    prompt(MESSAGES['flip_players'])
    loop do
      prompt(MESSAGES['get_first_player'])
      prompt(" ")
      input = gets.chomp.downcase
      break if ['i', 'c'].include?(input)
      prompt(MESSAGES['invalid_input'])
    end
    input == 'i' ? :user : :computer
  end
end

class Square
  attr_writer :mark

  def initialize
    @mark = nil
  end

  def blank?
    mark == Board::BLANK
  end

  def to_s
    mark
  end

  private

  attr_reader :mark
end

class Board
  NUM_SQUARES = 9
  BLANK = " "
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # Horizontal lines
                   [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical lines
                   [1, 5, 9], [3, 5, 7]] # diagonal lines
  MIDDLE_SQUARE = 5

  include UIMethods

  def initialize
    @user_marker = nil
    @computer_marker = nil
    @squares = {}
    initialize_squares
  end

  def reset
    (1..NUM_SQUARES).each { |num| squares[num].mark = BLANK }
  end

  def set_player_markers(user_marker, computer_marker)
    @user_marker = user_marker
    @computer_marker = computer_marker
  end

  # rubocop:disable Metrics/AbcSize
  def display
    clear_screen

    puts " #{squares[1]} | #{squares[2]} | #{squares[3]}  "
    puts "-----------"
    puts " #{squares[4]} | #{squares[5]} | #{squares[6]}  "
    puts "-----------"
    puts " #{squares[7]} | #{squares[8]} | #{squares[9]}  "
    puts " "
  end
  # rubocop:enable Metrics/AbcSize

  def user_won?
    WINNING_LINES.each do |line|
      return true if line.all? { |num| squares[num].to_s == user_marker }
    end
    false
  end

  def computer_won?
    WINNING_LINES.each do |line|
      return true if line.all? { |num| squares[num].to_s == computer_marker }
    end
    false
  end

  def full?
    available_squares.empty?
  end

  def mark_square(marker)
    if marker == user_marker
      user_choose_square
    elsif marker == computer_marker
      computer_choose_square
    end
  end

  private

  attr_reader :squares, :user_marker, :computer_marker

  def user_choose_square
    sqr_num = input_square_num
    squares[sqr_num].mark = user_marker
  end

  def computer_choose_square
    prompt(MESSAGES['computers_turn'])
    sleep(1)
    sqr_num = computer_square_num
    squares[sqr_num].mark = computer_marker
  end

  def initialize_squares
    (1..NUM_SQUARES).each { |square_num| squares[square_num] = Square.new }
  end

  def available_squares
    squares.select { |_, sqr| sqr.blank? }.keys
  end

  def input_square_num
    choice = nil
    loop do
      prompt(MESSAGES['choose_square'])
      prompt("Available squares: #{joinor(available_squares)}")
      choice = gets.chomp
      break if valid_input?(choice)
      prompt(MESSAGES['invalid_input'])
    end
    choice.to_i
  end

  def valid_input?(choice)
    choice.to_i.to_s == choice && available_squares.include?(choice.to_i)
  end

  def computer_square_num
    if offense_strategy_square_num
      offense_strategy_square_num
    elsif defense_strategy_square_num
      defense_strategy_square_num
    elsif available_squares.include?(MIDDLE_SQUARE)
      MIDDLE_SQUARE
    else
      available_squares.sample
    end
  end

  def offense_strategy_square_num
    valid_lines = WINNING_LINES.select do |line|
      valid_line?(line, computer_marker)
    end

    return nil if valid_lines.empty?
    blank_sqr_num(valid_lines.sample)
  end

  def defense_strategy_square_num
    valid_lines = WINNING_LINES.select { |line| valid_line?(line, user_marker) }

    return nil if valid_lines.empty?
    blank_sqr_num(valid_lines.sample)
  end

  def valid_line?(line, marker)
    markers = 0
    blanks = 0
    line.each do |sqr_num|
      case squares[sqr_num].to_s
      when marker then markers += 1
      when BLANK then blanks += 1
      end
    end
    markers == 2 && blanks == 1
  end

  def blank_sqr_num(line)
    line.each do |sqr_num|
      return sqr_num if squares[sqr_num].blank?
    end
  end
end

class Player
  include UIMethods

  attr_reader :score, :marker, :name
  attr_writer :marker, :name

  def initialize
    @score = 0
    @marker = nil
    @name = nil
  end

  def reset_score
    self.score = 0
  end

  def increment_score
    self.score = score + 1
  end

  private

  attr_writer :score
end

class TTTGame
  MAX_WINS = 3
  COMPUTER_NAMES = ['Windows', 'Macbook']
  COMPUTER_MARKER = "O"

  include UIMethods

  def initialize
    @board = Board.new
    @user = Player.new
    @computer = Player.new
    @player1 = nil
    @player2 = nil
  end

  def play
    pre_game_setup
    loop do
      play_until_max_win
      display_game_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_accessor :board, :user, :computer, :player1, :player2

  def play_until_max_win
    reset_scores
    loop do
      board.reset
      board.display
      play_single_round
      flip_first_player
      display_round_winner
      display_scores
      break if game_over?
    end
  end

  def play_single_round
    loop do
      player_1_mark_square
      break if round_over?
      player_2_mark_square
      break if round_over?
    end
  end

  def player_1_mark_square
    board.mark_square(player1.marker)
    board.display
  end

  def player_2_mark_square
    board.mark_square(player2.marker)
    board.display
  end

  def round_over?
    someone_won? || board.full?
  end

  def pre_game_setup
    display_welcome_message
    set_user_name
    set_markers
    display_names
    set_first_player
    board.set_player_markers(user.marker, computer.marker)
  end

  def set_user_name
    clear_screen
    name = input_user_name
    user.name = name.capitalize
    computer.name = COMPUTER_NAMES.sample
  end

  def set_markers
    clear_screen
    marker = input_user_marker
    user.marker = marker
    computer.marker = COMPUTER_MARKER
  end

  def display_names
    clear_screen
    prompt("Hello #{user.name}.")
    prompt(" ")
    prompt("You are playing against #{computer.name}.")
    prompt(" ")
    prompt("#{computer.name} is powered by AI developed at Launch School.")
    prompt(" ")
  end

  def set_first_player
    choice = user_input_first_player
    if choice == :user
      self.player1 = user
      self.player2 = computer
    else
      self.player1 = computer
      self.player2 = user
    end
  end

  def reset_scores
    user.reset_score
    computer.reset_score
  end

  def someone_won?
    board.user_won? || board.computer_won?
  end

  def display_round_winner
    if board.user_won?
      user.increment_score
      prompt("#{user.name} won the current round.")
    elsif board.computer_won?
      computer.increment_score
      prompt("#{computer.name} won the current round.")
    else
      prompt("Its a tie")
    end
    prompt(" ")
  end

  def display_scores
    prompt(MESSAGES['score'])
    prompt(" ")
    prompt("You: #{user.score}")
    prompt("Computer: #{computer.score}")
    prompt(" ")
    press_enter_to_continue
  end

  def game_over?
    user.score == MAX_WINS || computer.score == MAX_WINS
  end

  def display_game_winner
    prompt("Game over!")
    prompt(" ")
    if user.score == MAX_WINS
      prompt("#{user.name} won the game")
    elsif computer.score == MAX_WINS
      prompt("#{computer.name} won the game")
    end
  end

  def flip_first_player
    self.player1, self.player2 = player2, player1
  end
end

TTTGame.new.play

=begin

Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie. 


Nouns - player, move, rules
Verbs - chooses, compare

=end

class Choice
  attr_accessor :value

  VALUES = ['rock', 'paper', 'scissor']

  def initialize(value)
    @value = value
  end

  def >(other_choice)
    first = self.value
    second = other_choice.value

    (first == "rock" && second == "scissor") || (first == "scissor" && second == "paper") || (first == "paper" && second == "rock")
  end

  def to_s
    "#{@value}"
  end


end

class Player
  MOVES = ['rock', 'scissor', 'paper']
  attr_accessor :choice, :name

  def initialize 
    @choice = nil
    @name = set_name
  end

end

class Human < Player

  def set_name
    n = nil
    loop do
      puts "whats your name"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    n
  end

  def choose_move
    choice = ''
    loop do
      puts "Choose rock, scissor or paper"
      # puts "Enter r for rock, s for scissors or p for papers"
      choice = gets.chomp
      break if MOVES.include?(choice.downcase)
    end
    @choice = Choice.new(choice)
  end

end

class Computer < Player
  
  def set_name
    ['mac', 'win', 'lin', 'chr', 'ubu'].sample
  end


  def choose_move
    @choice = Choice.new(MOVES.sample)
  end

end


class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system("clear")
    puts "Welcome to Rock Paper Scissor"
  end

  def display_goodbye_message
    puts "Thanks for playing, Good Bye !"
  end

  def display_winner
    puts "#{human.name} chose #{human.choice}"
    puts "#{computer.name} chose #{computer.choice}"

    if human.choice > computer.choice
      puts "#{human.name} won"
    elsif
      computer.choice > human.choice
      puts "#{computer.name} won"
    else
      puts "Draw"
    end
    
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n"
    end

    if answer == 'y'
      return true
    else
      return false
    end
  end

  def play
    display_welcome_message

    loop do
      human.choose_move
      computer.choose_move
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

rps = RPSGame.new
rps.play
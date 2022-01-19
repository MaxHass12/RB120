# 1

# puts "Hello".class
# puts 5.class
# puts [1, 2, 3].class

# # 2

# class Cat; end

# #3

# kitty = Cat.new

# 4

# class Cat
#   def initialize
#     puts "I'm a cat"
#   end
# end

# kitty = Cat.new

# 5


# class Cat
#   def initialize(name)
#     @name = name
#     puts "Hello, my name is #{@name}"
#   end
# end

# kitty = Cat.new('Sophie')

# 6

# class Cat
#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{@name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

# 7

module Walkable
  def walk
    puts "Let's go for a walk"
  end
end

class Cat
  include Walkable

  attr_accessor :name


  def initialize(name)
    @name = name
  end

  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = "Luna"
kitty.greet
kitty.walk

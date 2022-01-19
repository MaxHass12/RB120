# 1

# class Cat
#   def self.generic_greeting
#     puts "Hello, I am a cat"
#   end
# end

# kitty = Cat.new

# kitty.class.generic_greeting

# 2

# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def rename(name)
#     self.name = name
#   end
# end

# kitty = Cat.new('Sophie')
# p kitty.name
# kitty.rename('Chloe')
# p kitty.name

# 3

# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def identify
#     self
#   end
# end

# kitty = Cat.new('Sophie')
# p kitty.identify

# 4

# class Cat
#   attr_reader :name

#   def self.generic_greeting
#     puts "All cats say hello"
#   end

#   def initialize(name)
#     @name = name
#   end

#   def personal_greeting
#     puts "Hello from #{self.name}"
#   end
# end

# kitty = Cat.new('Sophie')

# Cat.generic_greeting
# kitty.personal_greeting

# 5

# class Cat
#   @@n_cats = 0

#   def self.total
#     puts @@n_cats
#   end

#   def initialize
#     @@n_cats += 1
#   end

# end

# kitty1 = Cat.new
# kitty2 = Cat.new

# puts Cat.total

# 6

# class Cat
#   COLOR = "white"

#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello from #{COLOR} #{name}"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

# 7

# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "I am #{self.name}"
#   end
# end

# kitty = Cat.new('Sophie')
# puts kitty

# 8

# class Person
#   attr_accessor :secret

#   def initialize
#     @secret = ""
#   end

# end

# person1 = Person.new
# person1.secret = 'Shh.. this is a secret!'
# puts person1.secret

# 9

# class Person
#   attr_writer :secret

#   def share_secret
#     puts "#{secret}"
#   end

#   private

#   attr_reader :secret
# end

# person1 = Person.new
# person1.secret = 'Shh.. this is a secret!'
# person1.share_secret

# 10

class Person
  attr_writer :secret

  def compare_secret(other_person)
    secret == other_person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)



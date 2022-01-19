# 1

# module Mailable
#   def print_address
#     puts "#{name}"
#     puts "#{address}"
#     puts "#{city}, #{state} #{zipcode}"
#   end
# end

# class Customer
# include Mailable
# attr_reader :name, :address, :city, :state, :zipcode
# end

# class Employee
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# betty = Customer.new 
# bob = Employee.new
# betty.print_address
# bob.print_address

# 2

# module Drivable
#   def drive
#   end
# end

# class Car
#   include Drivable
# end

# bobs_car = Car.new
# bobs_car.drive

# 3

# class House
#   include Comparable
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end

#   def <=>(other)
#     price <=> other.price
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1

# 4

# class Transform
#   def initialize(text)
#     @text = text
#   end

#   def uppercase
#     @text.uppercase
#   end

#   def self.lowercase(string)
#     string.downcase
#   end
# end

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

# 5

# 6

# 7

# class Pet
#   attr_reader :name, :animal

#   def initialize(animal, name)
#     @animal = animal
#     @name = name
#   end
# end

# class Owner
#   attr_accessor :name, :number_of_pets

#   def initialize(name)
#     @name = name
#     @number_of_pets = 0
#   end
# end

# class Shelter
#   def initialize
#     @tally = {}
#   end
#   def adopt(owner, pet)
#     owner.number_of_pets += 1
    
#     if @tally[owner.name]
#       @tally[owner.name] << pet
#     else
#       @tally[owner.name] = [pet]
#     end
#   end

#   def print_adoptions
#     @tally.each do |k, v|
#       puts "#{k} has adopted following"
#       v.each { |pet| puts "a #{pet.animal} named #{pet.name}"}
#       puts " "
#     end
#   end
# end

# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding      = Pet.new('cat', 'Pudding')
# darwin       = Pet.new('bearded dragon', 'Darwin')
# kennedy      = Pet.new('dog', 'Kennedy')
# sweetie      = Pet.new('parakeet', 'Sweetie Pie')
# molly        = Pet.new('dog', 'Molly')
# chester      = Pet.new('fish', 'Chester')

# phanson = Owner.new('P Hanson')
# bholmes = Owner.new('B Holmes')

# shelter = Shelter.new
# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)
# shelter.print_adoptions
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# 8


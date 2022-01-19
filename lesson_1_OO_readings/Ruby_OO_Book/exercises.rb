# 1 - The Object Model

# 2 - Classes and Objects 1

# class MyCar
#   attr_accessor :color
#   attr_reader :year

#   def self.mileage(miles, gas)
#     puts "mileage is #{miles/gas}"
#   end

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#   end

#   def speed_up
#     @speed += 10
#     puts "Speed is now #{@speed}"
#   end

#   def brake
#     @speed -= 10
#     puts "Speed is now #{@speed}"
#   end

#   def shut_off
#     @speed = 0
#     puts "Speed is now #{@speed}"
#   end

#   def spray_paint(color)
#     @color = color
#     puts "Color is now #{color}"
#   end

#   def to_s
#     "This is a #{year} #{color} #{@model}"
#   end

# end

# c = MyCar.new(2012, "white", "camry")

# c.spray_paint("grey")

# puts c

# 4 Inheritence

#1)

# module Towable
#   def can_tow(pound)
#     pound < 200 ? true : false
#   end
# end

# class Vehicle
#   attr_accessor :color
#   attr_reader :year

#   @@num_of_vehicles = 0

#   def self.num_of_vehicles
#     puts "num of vehicles = #{@@num_of_vehicles}"
#   end

#   def self.mileage(miles, gas)
#     puts "Mileage is #{miles/gas}"
#   end

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     @@num_of_vehicles += 1
#   end

#   def speed_up
#     @speed += 10
#     puts "Speed is now #{@speed}"
#   end

#   def brake
#     @speed -= 10
#     puts "Speed is now #{@speed}"
#   end

#   def shut_off
#     @speed = 0
#     puts "Speed is now #{@speed}"
#   end

#   def spray_paint(color)
#     @color = color
#     puts "Color is now #{color}"
#   end

#   def age
#     "Your #{@model} is #{year_old} year old"
#   end

#   private

#   def year_old
#     Time.now.year - self.year
#   end

# end

# class MyCar < Vehicle
#   NUM_OF_SEATS = 5

#   def to_s
#     "The car is a #{year} #{color} #{@model} with #{NUM_OF_SEATS} seats"
#   end
# end

# class MyTruck < Vehicle
#   NUM_OF_SEATS = 2

#   include Towable
# end

# car1 = MyCar.new(2012, "white", "camry")
# puts car1
# puts car1.age
# puts car1.year_old


# 7)

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade   
  end

  def to_s
    "Name: #{@name}, Grade: #{@grade}"
  end

  protected

  def grade
    @grade
  end

end

joe = Student.new("joe", "A")
puts joe


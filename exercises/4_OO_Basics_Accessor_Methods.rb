# 1

# class Person
#   attr_accessor :name
# end

# person1 = Person.new
# person1.name = 'Jessica'
# puts person1.name

# 2

# class Person

#   def name=(name)
#     @name = name
#   end

#   def phone_number=(phone_number)
#     @phone_number = phone_number
#   end

#   def name
#     @name
#   end
# end

# person1 = Person.new
# person1.name = 'Jessica'
# person1.phone_number = '0123456789'
# puts person1.name

# 3

# class Person
#   attr_reader :phone_number

#   def initialize(number)
#     @phone_number = number
#   end
# end

# person1 = Person.new(1234567899)
# puts person1.phone_number

# person1.phone_number = 9987654321
# puts person1.phone_number

# 4

# class Person
#   attr_accessor :first_name
#   attr_writer :last_name

#   def first_equals_last?
#     first_name == last_name
#   end

#   private

#   attr_reader :last_name
# end

# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last?


# 5

# class Person
#   def first_equals_last?
#     first_name == last_name
#   end


# end

# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last?

# 6

# class Person
#   attr_reader :name

#   def name=(name)
#     @name = name.upcase
#   end
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

# 7

# class Person
#   attr_reader :name

#   def name=(name)
#     @name = "Mr " + name
#   end
# end

# person1 = Person.new
# person1.name = 'James'
# puts person1.name

# 8

# class Person

#   def initialize(name)
#     @name = name
#   end

#   def name
#     @name.clone
#   end
# end

# person1 = Person.new('James')
# person1.name.reverse!
# puts person1.name

# 9

class Person
  def age
    @age *2
  end

  def age=(age)
    @age = age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age






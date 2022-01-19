class Foo
  attr_accessor :x

  def initialize
    @x = "intial_x"
  end

  def a_method
    @y = "initial_y_from_method"
    puts @y
  end
end

class Bar < Foo
  def another_method
    puts @y
  end
end

b = Bar.new

puts b.x

b.a_method
b.another_method
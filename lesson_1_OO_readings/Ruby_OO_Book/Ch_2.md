**States and Behaviours**

- when defining a class we care primarily about 2 things - states and behaviours. States track attributes about specific objects, behaviour is what the object is capable of doing
- instance variables keep track of state of the object and instance methods expose behaviours of the object.
- instance variables are scoped at instance level and instance methods are available to the instances of the class

**Initializing a new object**

- `initialize` method gets called every time we create a new instance of the class
- called a constructor

**Instance variable**

- think of instance variable as representing a state or tracking a certain attribute of the object
- `@` symbol in front of it
- usually we initialize instance variables within the constructor method to values which are passed in as arguments during instantiation of the object
- Every object's state is unique and we keep track of it with instance variables (Get into the habit of thinking `@` when thinking about the instance variables)

**Instance methods**

- we can expose information regarding the attributes of the object using the instance methods
- instance methods are available to instances

**Accessor methods**

- If we want to access the object's name - think name of the dog sparky - we can not use `sparky.name` - it will give `NoMethodError`

- need to define a `get_name` method

- to change an instance variable, we need a setter method

  - however it is defined with an `=` operator ie `set_name=` and it is called using `set_name = "whatever we want to set"`

  - setter methods always return the value that is passed as argument, regardless of what happens inside the method

  - this can be done under the hood by `attr_accessor`

  - `attr_reader` if we only want to read the instance variable
  - `attr_writer` if we only want to modify the state

  -**Accessor methods in action**

  - `@name` is used to access instance variable - instead if we just use `name` then we are calling the getter method which returns `@name`

  - It is considered a good idea to use the getters within the class too, instead of instance variable

  - `attr_accessor :name, :height, :weight` - gives 3 pairs of setters and getters and also 3 instance variables

  - to disambiguate from creating a local variable within an instance method, we need to use `self` keyword.

  -

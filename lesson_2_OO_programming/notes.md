1. Introduction

2. Classes and Objects

- classes are blueprints and objects.
- Every object in ruby comes with `to_s` inherited from Object class - prints out some gibberish by default

3. Exercises

- Easy 1

  - Each object is an instance of a class. To find the class to which an object belongs, we invoke the `#class` method
  - We create a class by using the class keyword, named in CamelCase
  - We instantiae a new object by using the class method `::new`
  - When defining a class we usually need to define a constructor method - `#initialize` in Ruby
  - Instance variables exist only within an object instance. Can be reference only after the object is instantiated. They are differentiated by using `@` symbol at their start.
  - Instance methods are available only when there is an instance of the class - and can be invoked only upon the instance of the class
  - `attr_reader`, `attr_writer` and `attr_accessor` : provides the getters, setters and both respectively
  - Modules are typically used to contain methods that may be useful for multiple classes - but not all classes. When we mix a module into a class, we allow the class to invoke the contained methods

- Easy 2
  - We define class methods by prepending `self` . `self.a_class_method` `::a_class_method`
  - within the definition of setter method, we need to invoke the getter methods by prepending them with `self`
  - class methods are only associated with the class and not instances
  - public methods can be accessed from both within the class and outside the class
  - protected methods allow access between class instances, but not from outside the class

4. Inheritence

- to see the method lookup path we can use the `.ancestors` method

5. Exercises

- OO Basics - Inheritance

  - to reduce complexity, classes with similar behaviour can inherit from a super class. It is said that instance variables are also inherited from the superclass
  - In case of inheritence, Ruby stops looking for a method as soon as it finds it. What if we want to override a method, but still want access to functionality from the super class. `super` facilitates this.
  - we can decide to pass how many arguments we want by using `super` with arguments
  - `super` invokes the method in the inheritance hierarchy with the same name as the method in the child. To explicitly invoke the inherited method without passing any argument we need to use `super()` ie super with empty parans
  - it is possible to inherit from both classes and modules at same time
  - Every class in Ruby, except `BasicObject` inherits from one class or another
  - When a module is included in a class, the class is searched before the module. However the module is searched before the superclass.
  - Namespacing is grouping similar class in a module - makes it easier to recognize the purpose of the contained class - and also helps in avoiding collission with class of same name

6. Polymorphism and Encapsulation

- Polymorphism

  - Polymorphism is the ability of object of different type to respond to differently to a common interface ie method invocation

  - Polymorphism through Inheritence

    - ie we override the method in the children class and thus make 2 objects respond differently to the same method name

  - Polymorphism through Duck Typing

    - Duck typing occurs when objects of different unrelated types both respond to the same method name
    - As long as objects involved use the same method name and take same number of arguments
    - Duck typing is an informal way to classify objects - classes are more formal
    - for various unrelated classes which are all playable - ie musical instrument, games - since this classes are totally distinct - no polymorphism

- Encapsulation

  - Encapsulation lets us hide internal representation of an object from the outside and only expose methods and properties which the users of the object need
  - We use method access control to expose these properties and behaviours through the public interface of the object - ie the method
  - A class should have as few public methods as possible

7. Exercises

- Accessor Methods

- to set, let say `@name` instance variable, we have to use the instance method `name=`, `attr_writer` is the shortcut to do it
- we should not get carried away and use `#attr_accessor` for every instance variable
- when a method is private only the class, not the instances of the class, can access it. When a method is protected, the instances of the class or that of subclass can call that method. We can easily share sensitive data between instances of the same class type.
- getter methods typically return a reference to the instance variable - if we use this reference to mutate the return value, you also mutate the instance variable

8. Some Philosophical optional reading

9. Collaborator Objects

- classes group common behaviour and objects encapsulates state. An object's state is saved in an object's instance variables.
- instance variables can hold any object including data structures - even an object of custom class that we have created
- (custom) objects which are stored as states within another objects are called - 'collaborator' objects - usually we call custom objects as collaborator objects - although technically strings, integers, etc can be collaborator object
- play an important role in object oriented design - they represent connections between various actors in the program
- collaborator objects can also be thought of as representing a 'has-a' relationship

10. Modules

- In Ruby, a class can inherit from one class only - called single inheritence - in some cases this limitation could make it difficult to model the reality
- some programming languages allow multiple inheritence
- Ruby's answer is mixing in behaviours through modules

11. Exercises

- Easy 1

- Easy 2

  - methods inside a module can be added to a class simply by including the module into a class. Called mixin modules.
  - methods in mixin module should be defined without using `self` - in this case the methods will not be available as instance methods
  - making objects comparable is quite easy - you need to include the `comparable` mixin, and define one method `<=>` and make it work properly
  - need to distinguish between a class method and an instance method
  - modules are appropriate in a has-a relationship - a guideline is whether you want to have some additional functionality or you want to extend the abilities of the class -

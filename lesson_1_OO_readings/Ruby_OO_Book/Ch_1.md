_Why Object Oriented Programming_

- OOP programming paradigm was designed to deal with growing complexity of large software systems.

- _Encapsulation_

  - Hiding pieces of functionality and making it unavailable to the rest of code base
  - Its a form of data protection, so that data can not be changed without explicit intention
  - Done through creating objects and exposing interfaces (ie methods) to interact with those objects

- _Polymorphism_

  - ability of different type of data to respond to a common interface
  - One way is through inheritance
  - Another way to apply polymorphic structure to Ruby program is to use a `Module`.
  - Modules are similar to classes in that they contain shared behaviour, but you can not create an object with module. A module must be mixed in the class using the `include` keyword - aka mixin.

- _Inheritence_

  - when a class inherits behaviour of other class called superclass

**What are Objects**

- It is often said that everything in Ruby is an object - not literally true - anything that can be said to have a value is an object

- Objects are created from class. A non programming analogy - Dog is a class - this or that dog is an object of class Dog

**Classes define Objects**

- Ruby defines the behaviour and attributes of its objects in classes - Classes provide the basic outline of the behaviour and attributes of the class

- Creating a new object or an instance from the class is called instantiation

- For eg `GoodDog` class with an instance `sparky`. We say `sparky` is an object of or an instance of the `GoodDog` class.

**Modules**

- A module is a collection of behaviours that is usable in other classes via mixins

**Method Lookup**

- we can use `ancestors` method on any class to find out the method lookup chain

---

- We create an Object by defining a class and instantiating it using the `.new` method.

- A module is a group of reusable code which can be used in our class using the `include` keyword. They are also used as namespace.

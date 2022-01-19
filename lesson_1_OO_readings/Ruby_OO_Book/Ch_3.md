**Class Methods**

- so far we have looked at instance methods
- there are also class level methods - which we can call on the class, without having to instantiate any objects
- defined by prefixing the method name with `self.`

**Class Variables**

- just as instance variables capture information related to specific instance, we can create variables for capturing information related to entire class - called class variables - created by using `@@`

**Constants**

**to_s method**

- `to_s` instance methods comes build in with every class in Ruby
- by default, this outputs the name of object's class and an encoding of object id

- `to_s` is invoked automatically on the object when we use it with `puts` or when used in string interpolation

  - (`puts` calls `to_s` on its argument )
  - ( for array `puts` writes on separate line the result of calling the array)
  - (`to_s` is also automatically invoked during the string interpolation)

- there is another method called `p` which is very similar to `puts` - except it does not call `to_s` but rather `inspect` on its arguments - this is very helpful for debuggingn purpose and we do not want to override it

- `p sparky` is equiavlent to `puts sparky.inspect`

**More about self**

- `self` can refer to different things depending on the context

  - use `self` to disambiguate between local variable and class variables in setter method definition
  - use `self` for class method definition

- within the scope of an instance method uses `self` - it references the calling object - ie `sparky` in our examples

- Other place we use `self` is when we are defining the class methods - ie when `self` is prepended to a method definition ie `self` within the class but outside of the scope of the instance method, references the class itself

-

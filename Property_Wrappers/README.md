#  Property wrappers 
> A property wrapper adds a layer of separation between the code that manages how a property is stored and the code that defines a property. It is denoted by @propertyWrapper before the struct.

```
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
```

> The setter ensures that new values are less than or equal to 12, while the getter returns the stored value.

In the following code, the ```height``` and ```width``` variables are wrapped by the ```TwelveOrLess``` property wrapper. By default, their values are set to 0. Whenever a user assigns a value to height or width, the property wrapper ensures the assigned value does not exceed 12.

**Examples: **

```
struct Rectangle {
    @TwelveOrLess height: Int
    @TwelveOrLess var width: Int
}
```

```
@TwelveOrLess number = 10
print(number)

//prints 10
```

```
@TwelveOrLess number = 15
print(number)

//prints 12
```

**Why Use Property Wrappers?**
Property wrappers are a powerful tool in Swift for reusing code that enforces certain constraints or behaviors on properties. For example:

Imagine you have a database with a ```Student``` entity, and the ```password``` property must always be at least 8 characters long. Instead of repeating the validation logic every time the password is updated, you can create a property wrapper to enforce this rule consistently and reliably.

**Projected Values**
Another feature of property wrappers is projected values. A projected value provides an alternative view or representation of the property. It is accessed by prefixing the property with a ``` $ ``` symbol.


for instance:

```
@propertyWrapper
struct MyString {
    private var myString = ""
    var wrappedValue: String {
        get { return myString }
        set { myString = newValue }
    }
    
    var projectedValue: String {
        return myString.uppercased()
    }
}


struct HelloWorld{
  @MyString var helloString = "Hello, world!"
}

var myObject = HelloWorld()

print(myObject.helloString)
//prints "Hello, world!"
```

Why Do We Use ``` wrappedValue ``` and ``` $ ```?
The Swift compiler uses specific naming conventions (wrappedValue and $) to identify property wrappers and their projected values. These conventions ensure that the wrapper works seamlessly with the compiler, even when dealing with complex properties or multiple wrappers.

```
print(myObject.$helloString)
//prints "HELLO, WORLD!"
```

> By default, accessing the property (helloString) returns its wrappedValue. To access the projectedValue, prefix the property with ```$```
# State management in SwiftUI 
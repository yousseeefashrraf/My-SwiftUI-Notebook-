#  Property wrappers 
> A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property denoted by @propertyWrapper before the struct.

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

> The setter ensures that new values are less than or equal to 12, and the getter returns the stored value.


In the next code, the height variable goes to the property wrapper and sets itself to initial value which is Zero. Any time the user tries to initiate  "height" or "width" is a value, it goes to the property wrapper called TwelveOrLess and says: what is the minimum between the value the user want to set and 12? and sets the value of the number inside TwelveOrLess to that value. Wether it's 12 or the value that the user wants to set.

```
struct Rectangle {
    @TwelveOrLess height: Int
    @TwelveOrLess var width: Int
}
```

Lets see an examples: 

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

So let's try to understand whats going one, and why would i ever need to use property wrappers?

In fact, property wrappers is a strong thing to have in swift. Lets assume that i have a connection to a database and that database has a student entity for example that has a password that has to be 8 chars long. Everytime the student wants to update that password i would need to check if that password has 8 characters or not, how would i do that? well, using **property wrappers**! 

Another thing that property wrappers has is **projectedValues**.
A projected value is like another shape or look for how my variable looks like!
for example:
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

Well, so far there is nothing new! the print statement prints whats expected and the projected value is not touched so far. to denote that we actually want the print the projected value we need to put "$" before it. Doesn't make sense right?

To understand, we need to see how does swift know that the specified value for the wrappedValue after = in ``` @MyString var helloString = "Hello, world!" ``` what if i have other properties? Well, that's why  we HAVE to name it wrappedValue. in the same way, we have to use "$" before our variable. Otherwise, how would swift even know? 

```
print(myObject.$helloString)
//prints "HELLO, WORLD!"
```
# State management in SwiftUI 
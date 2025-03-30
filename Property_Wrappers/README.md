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

### Examples: 

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

## Why Use Property Wrappers?
Property wrappers are a powerful tool in Swift for reusing code that enforces certain constraints or behaviors on properties. For example:

Imagine you have a database with a ```Student``` entity, and the ```password``` property must always be at least 8 characters long. Instead of repeating the validation logic every time the password is updated, you can create a property wrapper to enforce this rule consistently and reliably.

## Projected Values
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

### Why Do We Use ``` wrappedValue ``` and ``` $ ```?
The Swift compiler uses specific naming conventions (wrappedValue and $) to identify property wrappers and their projected values. These conventions ensure that the wrapper works seamlessly with the compiler, even when dealing with complex properties or multiple wrappers.

```
print(myObject.$helloString)
//prints "HELLO, WORLD!"
```

> By default, accessing the property (helloString) returns its wrappedValue. To access the projectedValue, prefix the property with ```$```


# State management in SwiftUI 
> ```
> @State, @Binding, @ObservedObject, @EnvironmentObject, and @Environment
> ```
> Views are immutable by default. 


### ```@State```

As views are immutable, if we need to store a vriable we need to use @State. what it really does is that it stores the variable in external memory. Each time the State variable changes it notifies the view and it redraws it self.

### ```@Binding```

Binding is almost the same as State. The only difference is that it uses a refrence of the state variablel. Why? if we use @State instead of @Binding or if we don't use any of them, that means that we are restoring a **copy** of that variable, and most of the time that's not what we want our application to behave like. Instead, we need to store a refrence of that @State variable; Why? because each time the variable changes we want to notify the view that has that variable, or any other view refrencing it, to update it self!

### ``` @ObservedObject VS @StateObject ```

#### Refrences: 
- https://pedroalvarez-29395.medium.com/swiftui-stateobject-x-observedobject-when-to-use-each-one-f738eb57ba6e

- https://www.youtube.com/watch?v=RvzJLekIjRs

##### ```@ObservedObject - Notes ```

Why does the observed variable resets whenever it's contained withing a parent view? that's because each time the view is reloaded/redrawn the observed object gets a new instance which requires the old one to be removed!

```
import SwiftUI
class User: ObservableObject{
    @Published var id: Int
    init(id: Int) {
        self.id = id
        print("Yes, new one!")
    }
}

struct SmallView: View{
    @ObservedObject var user: User = User(id: (0...100).randomElement()!)
    
    var body: some View{
        Text("\(user.id)")
            .font(.title)
        
        Button(){
            user.id += 1
        } label: {
            Text("Increment2")
                .foregroundStyle(.white)
                .padding(20)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
struct ContentView: View {
    @State var counter: Int = 0
    var body: some View {
        VStack {
            SmallView()
            Text("Counter: \(counter)")
                .font(.title)
            Button(){
                counter += 1
            } label: {
                Text("Increment")
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

```

Each time the "Increment" is clicked,  the small view get recomputed!

Lets actually see what's happening in memory here, if we add some few lines to our code:  
  
```
struct SmallView: View{
    @ObservedObject var user: User = User(id: (0...100).randomElement()!)

    var body: some View{
     //new line   
        let userPointer = UnsafePointer<User>(Unmanaged.passUnretained(user).toOpaque().assumingMemoryBound(to: User.self))

        Text("\(user.id)")
            .font(.title)
        
        Button(){
            print(userPointer)
            user.id += 1
            
        } label: {
            Text("Increment2")
                .foregroundStyle(.white)
                .padding(20)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
```


  ```
  Prints as following:
  
  Yes, new one!
Yes, new one!
Yes, new one!
0x00006000002617c0
0x00006000002617c0
0x00006000002617c0
Yes, new one!
0x000060000021c6c0
0x000060000021c6c0
0x000060000021c6c0
Yes, new one!
Yes, new one!
Yes, new one!
0x0000600000230040
0x0000600000230040
  
  ```
  
  What does this mean, is that there is a new instance allocated each tim the parent view is updated!
  
  How can we avoid that problem? by using ``` @StateObject ``` which is much likely like ```@State```
  
  
>  Using ChatGPT

| Property Wrapper  | Who Owns It?                     | When to Use?                               | Lifecycle Behavior                                   |
|------------------|--------------------------------|--------------------------------|------------------------------------------|
| `@StateObject`   | The view that declares it     | When creating a new instance inside a view | Retains the object for the lifetime of the view |
| `@ObservedObject` | The parent view or another source | When passing an existing object to a child view | Does not retain the object; expects an external owner |



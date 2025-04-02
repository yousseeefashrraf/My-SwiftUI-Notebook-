/*
 Refrences to look at:
 1- https://sarunw.com/posts/what-is-keyp...
 
 2- https://www.youtube.com/watch?v=2-fzccDtc7o
 
 
 
 */




import SwiftUI
import Foundation

class Human{
    var name: String
    var age: Int
    var country: String
    
    init(name: String, age: Int, country: String) {
        self.name = name
        self.age = age
        self.country = country
    }
}


var youssef = Human(name: "Youssef Ashraf", age: 20, country: "Egypt")


// How to define a keypath: KeyPath<type, type>
// keypath ---> \Type.Property

let keypathOfAge: KeyPath<Human /*Type*/
                          ,Int /*Property*/> = \Human.age

// How to set/get a property using a key path
print(youssef[keyPath: keypathOfAge]) // should print age
//differenct syntax:
print(youssef[keyPath: \.age]) // ---> swift can infer to the type

//gets the whole object
youssef[keyPath: \Human.self]
print(youssef[keyPath: \Human.self])

//same as \Human.age
youssef[keyPath: \Human.self.age]
/*^*/ print(youssef[keyPath: \Human.self.age])


//Another example here!

class Car {
    var model: String
    var owner: String
    
    init(model: String, owner: String) {
        self.model = model
        self.owner = owner
        
        print(self)
    }
}

//lets see what the init will print int the console!

let myCar = Car(model: "Tesla", owner: "Youssef Ashraf")
// Hmm, prints almost the same as the statement in the line that marked with /*^*/, intersting, the only type is different which actually makes sense!



class Car2 {
    var model: String
    var owner: String
    
    init(model: String, owner: String) {
        self.model = model
        self.owner = owner
        
        print(\Car2.model)
    }
    
    func tryWhateverYouWant(){
        print(\Car2.self.model)
    }
}
                      /****       Both of them prints the same       */

let myCar2 = Car2(model: "Tesla", owner: "Youssef Ashraf")
myCar2.tryWhateverYouWant()

let myCar3 = Car2(model: "Tesla", owner: "Youssef Ashraf")
myCar3.tryWhateverYouWant()




/**
 ***                       Filter & Map in arrays
 */

let myArray = ["Youssef", "Ahmed", "Ashraf", "Yomna", "Yuri"]

let nameOfY  =   myArray.filter {
    return $0.contains("Y")
}

// How to map using a keyPath

let charsOfEachOne = myArray.map(\.count) // -> what this actually does is it maps myArray based on the count


//Sort comperator and keyPath comperator


// This sorts the array baed on how many character are in them <<Ascending>>
let nameOfY2 = myArray.sorted(using: KeyPathComparator(\String.count))


// ---> Next, Dynamic member lookup






import SwiftUI


class Car{
    var nameOfCar: String
    var ownerOfTheCar: Owner? = nil
    
    init(nameOfCar: String, ownerOfTheCar: Owner? = nil) {
        self.nameOfCar = nameOfCar
        self.ownerOfTheCar = ownerOfTheCar
    }
    
    deinit{
        print("Done car")
    }
}
class Owner{
    var name: String
    weak var car: Car? = nil
   
    init(name: String, car: Car? = nil) {
        self.name = name
        self.car = car
    }
    deinit{
        print("Done owner")
    }
}

var car: Car? = Car(nameOfCar: "Toyota")
var owner = Owner(name: "Youssef Ashraf", car: car)
car?.ownerOfTheCar = owner
/*
            
 ========== Visual ===========
 
 var car        var owner
    |                |
 --------  Strong --------
|        | ----> |        |
|        | <---- |        |
|        | Weak  |        |
|________|       |________|
 
 =============================
 */
car = nil
/*
            
=========== Visual ===========
 
 var car        var owner
                     |
 --------  Strong --------
| Car    | ----> | Owner  |
|instance| <---- |instance|
|        | Weak  |        |
|________|       |________|
 
=============================
 
 As there is only on weak ref. for the instance the ARC sets it nil
 
 Note: value types can't be marked with unowned; because weak or unowned just works with refrence type such as class. if you try to make someValueType1 = someValueType2, the someValueType1 would copy the someValueType2, unless they are classes then it would have a strong ref. to it!
 
 
 */
// Try it out!
print("The result of the weak ref.: \(String(describing: owner.car))")



//Another example with retain cycle between a closure and a class

class SomeClass{
    var x = 10
    var myClosure: (()->Int)? = nil
    func returnFunction() -> ()->Int{
        return {
             self.x += 1
            
            return self.x
        }
    }

    deinit{
        print("Done!")
    }
    
}


var x: SomeClass? = SomeClass()
var closure = x?.returnFunction()
x?.myClosure = closure

//Virtual look in memory
/*
 
 ========= Some Class Instance <<Self>> ===========
|                  (Strong)                        |(Strong)
|        myClosure  ------                         |<-----|
|                         |     _-----------_      |      |
|                         |--->| The Closure |-----|------
|                               '-----------'      |
|                                                  |
====================================================
 
 
 */
closure?()
x = nil

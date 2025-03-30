ARC
Automatic Refrence Counting 


What is automatic refrence counting?
ARC is a counter that keeps track of every instance of a class in the memory. It automatically manages the memory for you and deallocates memory when it's not used.￼!

lets assume that we have an object ```Car``` and we have four variables that points to it:
```
class Car{
    var nameOfCar: String
    
    init(nameOfCar: String) {
        self.nameOfCar = nameOfCar
    }
    
    deinit{
      print("Done!")
    }
}

var carInstance = Car("Toyota")

var myCar1 = carInstance
var myCar2 = carInstance
var myCar3 = carInstance
var myCar4 = carInstance


// ARC is 5
```


￼![Image](assets/IMG_1.png)

ARC would be 5 as there is five variables are refrencing the instance of a ```Car``` . However, if we try to give any of those variables a new instance, the deinit wouldn't get called and our object wouldn't get deinitialized. We have to set evrey variable to a new value so the ARC becomes 0 for that instance. Only then the instance would be deinitalized!

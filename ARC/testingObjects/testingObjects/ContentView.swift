//
//  ContentView.swift
//  testingObjects
//
//  Created by Youssef Ashraf on 04/07/2025.
//

import SwiftUI

class ViewModel: ObservableObject{
    @Published var counter: Int = 0
    
    init(){
        print("View model is being intiallized")
    }
    
    deinit{
        print("View model is being deintiallized")
    }
}

struct ContentView: View {
    @ObservedObject var vm = ViewModel()
    var body: some View {
        HStack {
            Text("Counter 1:") + Text("\(vm.counter)")
            Text("Increase first")
                .onTapGesture {
                    vm.counter += 1
                }
            
           
            
        }
        
        .padding()
        
        SecondView()
    }
}

struct SecondView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        HStack {
            Text("Counter 2: \(vm.counter)")
            Text("Increase Second")
                .onTapGesture {
                    vm.counter += 1
                }
        }
        .padding()
    }
}

class ViewModelDQ{
    func runSyncOnGlobal1(){
        DispatchQueue.global().sync {
            print("First global sync: ")
            print("Hello: 1")
            print("Hello: 2")
            print("Hello: 3")
            print("Hello: 4")
        }
    }
    
    func runSyncOnGlobal2(){
        DispatchQueue.global().sync {
            print("Second global sync: ")
            print("Hello: 1")
            print("Hello: 2")
            print("Hello: 3")
            print("Hello: 4")
        }
    }
    
    func runSyncOnGlobal3(){
        DispatchQueue.global().sync {
            print("Third global sync: ")
            print("Hello: 1")
            print("Hello: 2")
            print("Hello: 3")
            print("Hello: 4")
        }
    }
}

#Preview {
    ContentView()
}

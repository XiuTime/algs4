//: [Previous](@previous)

import Foundation

let timer = Timer(timeInterval: 1, repeats: true) { timer in
    print("123")
}
//timer.fireDate = .distantPast
timer.fireDate = .distantFuture

timer.fire()

RunLoop.current.add(timer, forMode: .common)
RunLoop.current.run()
//: [Next](@next)

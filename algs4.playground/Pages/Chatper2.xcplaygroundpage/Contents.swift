//: [Previous](@previous)

import Foundation

class SortExample {
    private static func selectionSort<T: Comparable>(_ list: inout [T]) {
        for i in stride(from: 0, to: list.count, by: 1) {
            var minIndex = i
            for j in stride(from: i, to: list.count, by: 1)
            where list[j] < list[minIndex] {
                minIndex = j
            }
            list.swapAt(i, minIndex)
        }
    }
    private static func insertionSort<T: Comparable>(_ list: inout [T]) {
        for i in stride(from: 1, to: list.count, by: 1) {
            for j in stride(from: i, through: 1, by: -1)
            where list[j] < list[j-1] {
                list.swapAt(j, j-1)
            }
        }
    }
    public static func sort<T: Comparable>(_ list: inout [T]) {
        //selectionSort(&list)
        insertionSort(&list)
    }
    
    public static func isSort<T: Comparable>(_ list: [T]) -> Bool {
        for i in stride(from: 1, to: list.count, by: 1)
        where list[i] < list[i - 1] {
            return false
        }
        return true
    }
}

var a = [0,1,2,3,4,5,6,7,8,9,10].shuffled()
SortExample.sort(&a)
print(a)
//: [Next](@next)

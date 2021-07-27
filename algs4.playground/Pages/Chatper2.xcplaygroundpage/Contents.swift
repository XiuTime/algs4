//: [Previous](@previous)

import Foundation

class SortExample {
    enum SortType {
        case selection
        case insertion
        case shell
    }
    /// 选择排序 找到最小的放到第一个位置，第二小的放在第二个位置以此类推
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
    //插入排序 将序列分为两段，前一段一定为有序的，遍历后一段的元素插入前面。
    private static func insertionSort<T: Comparable>(_ list: inout [T]) {
        for i in stride(from: 1, to: list.count, by: 1) {
            for j in stride(from: i, through: 1, by: -1)
            where list[j] < list[j-1] {
                list.swapAt(j, j-1)
            }
        }
    }
//   希尔排序 比较相隔较远距离（称为增量）的数，使得数移动时能跨过多个元素，则进行一次比较就可能消除多个元素交换。
    //算法先将要排序的一组数按某个增量d分成若干组，每组中记录的下标相差d.对每组中全部元素进行排序，然后再用一个较小的增量对它进行分组，在每组中再进行排序。当增量减到1时，整个要排序的数被分成一组，排序完成。
//    一般的初次取序列的一半为增量，以后每次减半，直到增量为1。
    private static func shellSort<T: Comparable>(_ list: inout [T]) {
        var d = 1
        let length = list.count
        while d < length/3 {d = d * 3 + 1}
        while d >= 1 {
            for i in stride(from: d, to: list.count, by: d) {
                for j in stride(from: i, through: 1, by: -d)
                where list[j] < list[j-d] {
                    list.swapAt(j, j-d)
                }
            }
            d /= 3
        }
    }
    
    public static func sort<T: Comparable>(_ list: inout [T], _ type: SortType) {
        switch type {
        case .insertion:
            insertionSort(&list)
        case .selection:
            selectionSort(&list)
        case .shell:
            shellSort(&list)
        }
    }
    
    public static func isSort<T: Comparable>(_ list: [T]) -> Bool {
        for i in stride(from: 1, to: list.count, by: 1)
        where list[i] < list[i - 1] {
            return false
        }
        return true
    }
}

var a = Array(0..<500).shuffled()
let startTime = CFAbsoluteTimeGetCurrent()
SortExample.sort(&a, .insertion)
let endTime = CFAbsoluteTimeGetCurrent()
debugPrint("代码执行时长：%f 毫秒", (endTime - startTime)*1000)

print(a)

//: [Next](@next)

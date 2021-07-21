
class BinarySearch {
    static func mian<T: Comparable>(key: T, list: [T]) {
        let sortList = list.sorted(by: <)
        print(rank(key: key, list: sortList))
    }
    
    static func rank<T: Comparable>(key: T, list:[T]) -> Int {
        var lh = 0, lt = list.count - 1
        while lh <= lt {
           let mid = lh + (lt - lh) / 2
            if list[mid] > key {
                lt = mid - 1
            } else if list[mid] < key {
                lh = mid + 1
            } else {
               return mid
            }
        }
        return -1
    }
}

//MARK: Stack LinkList implemention
class Stack<Element> {
    
    class Node {
        let item: Element
        var next: Node?
        
        init(item: Element, next: Node?) {
            self.item = item
            self.next = next
        }
        
        convenience init(item: Element) {
            self.init(item: item, next: nil)
        }
    }
    
    private var first: Node? = nil
    private var N: UInt = 0
    
    
    var isEmpty: Bool {
        return N == 0
    }
    
    var size: UInt {
        return N
    }
    
    func push(item: Element) {
        let oldFirst = first
        first = Node(item: item, next: oldFirst)
        N += 1
    }
    
    func pop() -> Element? {
        let item = first?.item
        first = first?.next
        N -= 1
        return item
    }
}

extension Stack {
    static func test() {
        let a = [1,2,3,4,5,6]
        let stack = Stack<Int>()
        print("before push")
        print("stack.isEmpty:\(stack.isEmpty)")
        a.forEach { item in
            stack.push(item: item)
        }
        print("after push")
        print("stack.size:\(stack.size)")
        print("stack.isEmpty:\(stack.isEmpty)")
        
        while !stack.isEmpty {
            print(stack.pop()!)
        }
    }
}

//MARK: Queue LinkList implemention
class Queue<Element> {
    class Node {
        let item: Element
        var next: Node?
        
        init(item: Element, next: Node?) {
            self.item = item
            self.next = next
        }
        
        convenience init(item: Element) {
            self.init(item: item, next: nil)
        }
    }
    
    var first: Node? = nil
    var last: Node? = nil
    
    var N: UInt = 0
    
    var isEmpty: Bool {
        return N == 0
    }
    
    var size: UInt {
        return N
    }
    
    func enqueue(item: Element) {
        let oldLast = last
        last = Node(item: item)
        oldLast?.next = last
        if isEmpty { first = last }
        N += 1
    }
    
    func dequeue() -> Element? {
        let item = first?.item
        first = first?.next
        if isEmpty { last = nil}
        N -= 1
        return item
    }
}

extension Queue {
    static func test() {
        let a = [1,2,3,4,5,6]
        let queue = Queue<Int>()
        print("before push")
        print("queue.isEmpty:\(queue.isEmpty)")
        a.forEach { item in
            queue.enqueue(item: item)
        }
        print("after push")
        print("queue.size:\(queue.size)")
        print("queue.isEmpty:\(queue.isEmpty)")
        
        while !queue.isEmpty {
            print(queue.dequeue()!)
        }
    }
}


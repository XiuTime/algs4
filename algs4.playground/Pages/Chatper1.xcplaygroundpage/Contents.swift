
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
extension Stack: Sequence {
    class StackIterator: IteratorProtocol {
        var head: Node?
        init(head: Node?) {
            self.head = head
        }
        func next() -> Element? {
            if head == nil {
                return nil
            } else {
                let item = head?.item
                head = head?.next
                return item
            }
        }
    }
    func makeIterator() -> StackIterator {
        return StackIterator(head: first)
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
        
        for (index, element) in stack.enumerated() {
            print("\(index) = \(element)")
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
    
    private var first: Node? = nil
    private var last: Node? = nil
    
    private var N: UInt = 0
    
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

extension Queue: Sequence {
    class QueueIterator : IteratorProtocol {
        typealias T = Element
        var head: Node?
        init(head: Node?) {
            self.head = head
        }
        func next() -> T? {
            if head == nil {
                return nil
            } else {
                let item = head?.item
                head = head?.next
                return item
            }
        }
    }
    
    typealias Iterator = QueueIterator
    func makeIterator() -> Iterator {
        return QueueIterator(head: first)
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
        
//        while !queue.isEmpty {
//            print(queue.dequeue()!)
//        }
        for (index, element) in queue.enumerated() {
            print("\(index) = \(element)")
        }
    }
}



class MaxPQ {
    var pq: [Int]
    private var N = 0
    init(max: Int) {
        pq = [Int](repeating: 0, count: max + 1)
        
    }
    
//        init(a : [T]) {
//
//        }
    
    func insert(v: Int) {
        N += 1
        pq[N] = v
        swim(k: N)
    }
    
//        func max() -> T {
//
//        }
    
    func delMax() -> Int {
        let max = pq[1]
        pq.swapAt(1, N)
        N -= 1
        pq.removeLast()
        sink(k: 1)
        return max
    }
    
    func isEmpty() -> Bool {
        return N == 0
    }
    
    func size() -> Int {
        return N
    }
    
    func swim(k: Int) {
        var k = k
        while k > 1 && pq[k] > pq[k/2] {
            pq.swapAt(k, k/2)
            k /= 2;
        }
    }
    
    func sink(k: Int) {
        var k = k
        while 2*k < N {
            var j = 2*k+1
            if j < N && pq[j] < pq[j-1] {
                j -= 1
            }
            
            if pq[k] > pq[j] {
                break
            }
            pq.swapAt(k, j)
            k = j
        }
    }
}

let maxpq = MaxPQ(max: 10)
for i in stride(from: 0, to: 10, by: 1) {
    maxpq.insert(v: i)
}
print(maxpq.pq)
maxpq.delMax()
print(maxpq.pq)
maxpq.delMax()



print(maxpq.pq)


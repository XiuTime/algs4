//: [Previous](@previous)

import Foundation

class Bag<Element> {
    
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
    
    func add(item: Element) {
        let oldFirst = first
        first = Node(item: item, next: oldFirst)
        N += 1
    }
}
extension Bag: Sequence {
    class BagIterator: IteratorProtocol {
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
    func makeIterator() -> BagIterator {
        return BagIterator(head: first)
    }
}


class Graph {
    public let V: Int
    
    private(set) var E: Int
    
    private var adj: [Bag<Int>]
    
    init(v: Int) {
        self.V = v
        self.E = 0
        self.adj = []
        for _ in 0..<v {
            self.adj.append(Bag<Int>())
        }
    }
    public func addEdge(v: Int, w: Int) {
        adj[v].add(item: w)
        adj[w].add(item: v)
        E += 1
    }
    
    public func adj(v: Int) -> Bag<Int> {
        return self.adj[v]
    }
    
    public func toString() -> String {
        var s = "\(V) vertices, \(E) edges\n"
        for v in 0 ..< V {
            s += "\(v): "
            for w in adj(v: v) {
                s += "\(w) "
            }
            s += "\n"
        }
        return s
    }
    
    static func degree(G: Graph, v: Int) -> Int {
        var degree = 0
        degree = Int(G.adj(v: v).size)
        return degree
    }
    
    static func maxDegree(G: Graph) -> Int {
        var maxDegree = 0
        for v in 0 ..< G.V {
            maxDegree = max(Graph.degree(G: G, v: v), maxDegree)
        }
        return maxDegree
    }
    
    static func avgDegree(G: Graph) -> Double {
        return Double(G.E) / Double(G.V) * 2.0
    }
    
    static func numsOfSelfLoop(G: Graph) -> Int {
        var count = 0
        for v in 0 ..< G.V {
            for w in G.adj(v: v) where v == w{
                count += 1
            }
        }
        return count / 2
    }
}

class DepthFirstSearch {
    private var marked: [Bool]
    private(set) var count: Int = 0
    init(G: Graph, s: Int) {
        marked = Array(repeating: false, count: G.V)
        dfs(G: G, v: s)
    }
    
    private func dfs(G: Graph, v: Int) {
        marked[v] = true
        count += 1
        for w in G.adj(v: v) where !marked[w] {
            dfs(G: G, v: w)
        }
    }
    
    public func marked(v: Int) -> Bool {
        return marked[v]
    }
    
}

let graph = Graph(v: 10)
graph.addEdge(v: 0, w: 1)
graph.addEdge(v: 0, w: 2)
graph.addEdge(v: 0, w: 3)
graph.addEdge(v: 0, w: 4)
graph.addEdge(v: 0, w: 0)
graph.addEdge(v: 1, w: 7)
graph.addEdge(v: 7, w: 9)

let search = DepthFirstSearch(G: graph, s: 0)
print(search.marked(v: 8))

//: [Next](@next)

//: [Previous](@previous)

import Foundation


class BST<Key: Comparable, Value> {
    
    private class Node {
        var key: Key
        var value: Value?
        var left: Node?
        var right: Node?
        var N: Int
        init(key: Key, value: Value?, n: Int) {
            self.key = key
            self.value = value
            self.N = n
        }
    }
    
    
    public subscript(key: Key) -> Value? {
        get {
            return get(key: key)
        }
        set {
            put(key: key, value: newValue)
        }
    }
    
    public var size: Int {
        return size(node: root)
    }
    
    public var min: Key? {
        return min(node: root)?.key
    }
    
    public var max: Key? {
        return max(node: root)?.key
    }
    
    
    public func floor(key: Key) -> Key? {
        return floor(node: root, key: key)?.key
    }
    
    public func ceiling(key: Key) -> Key? {
        return ceiling(node: root, key: key)?.key
    }
    
    public func select(index: Int) -> Key? {
        return select(node: root, index: index)?.key
    }
    
    public func deleteMin() {
        root = deleteMin(node: root)
    }
    
    public func delete(key: Key) {
        root = delete(node: root, key: key)
    }
    
    private var root: Node?
    
    private func size(node: Node?) -> Int {
        guard let node = node else {return 0}
        return node.N
    }
    
    private func get(key: Key) -> Value? {
        return get(node: root, key: key)
    }
    
    private func get(node: Node?, key: Key) -> Value? {
        guard let node = node else {return nil}
        if node.key < key {
            return get(node: node.right, key: key)
        } else if node.key > key {
            return get(node: node.left, key: key)
        } else {
            return node.value
        }
    }
    
    private func put(key: Key, value: Value?) {
        root = put(node: root, key: key, value: value)
    }
    
    private func put(node: Node?, key: Key, value: Value?) -> Node? {
        guard let node = node else {
            return Node(key: key, value: value, n: 1)
        }
        if node.key < key {
            node.right =  put(node: node.right, key: key, value: value)
        } else if node.key > key {
            node.left =  put(node: node.left, key: key, value: value)
        } else {
            node.value = value
        }
        node.N = size(node: node.left) + size(node: node.right) + 1
        
        return node
    }
    
    private func min(node: Node?) -> Node? {
        guard let left = node?.left else {return node}
        return min(node: left)
    }
    
    private func max(node: Node?) -> Node? {
        guard let right = node?.right else {return node}
        return max(node: right)
    }
    
    private func floor(node: Node?, key: Key) -> Node? {
        guard let node = node else {return nil}
        if node.key == key {
            return node
        }
        if node.key > key {
            return floor(node: node.left, key: key)
        }
        
        if let t = floor(node: node.right, key: key) {
            return t
        } else {
            return node
        }
    }
    
    private func ceiling(node: Node?, key: Key) -> Node? {
        guard let node = node else {return nil}
        if node.key == key {
            return node
        }
        if node.key < key {
            return floor(node: node.right, key: key)
        }
        
        if let t = floor(node: node.left, key: key) {
            return t
        } else {
            return node
        }
    }
    
    private func select(node: Node?, index: Int) -> Node? {
        guard let node = node else {
            return nil
        }
        let t = size(node: node.left)
        if index < t {
            return select(node: node.left, index: index)
        } else if index > t {
            return select(node: node.right, index: index - t - 1)
        } else {
            return node
        }
    }
    private func deleteMin(node: Node?) -> Node? {
        guard let left = node?.left else {
            return node?.right
        }
        node?.left = deleteMin(node: left)
        node?.N = size(node: left) + size(node: node?.right) + 1
        return node
    }
    
    private func delete(node: Node?, key: Key) -> Node? {
        guard var node = node else {return nil}
        if key < node.key {
            node.left = delete(node: node.left, key: key)
        }
        else if key > node.key {
            node.right = delete(node: node.right, key: key)
        }
        else {
            if node.right == nil {return node.left}
            if node.left == nil {return node.right}
            if let t = min(node: node.right) {
                t.right = deleteMin(node: node.right)
                t.left = node.left
                node = t
            }
        }
        node.N = size(node: node.left) + size(node: node.right) + 1
        return node
    }
    public func printM() {
        printM(node: root)
    }
    private func printM(node: Node?) {
        guard let node = node else {return}
        printM(node: node.left)
        print(node.key)
        printM(node: node.right)
    }
}

let bst = BST<Int, String>()
let a = [(2,"A"),(3,"B"),(4,"C"),(5,"D"),(6,"E"),(7,"F"),(8,"G"),(9,"H"),(10,"I"), (11, "J")].shuffled()
for t in a {
    bst[t.0] = t.1
}



class RBT<Key: Comparable, Value> {
    
    private let RED = true
    private let BLACK = false
    
    private class Node {
        var key: Key
        var value: Value?
        var left: Node?
        var right: Node?
        var N: Int
        var color: Bool
        init(key: Key, value: Value?, n: Int, color: Bool) {
            self.key = key
            self.value = value
            self.N = n
            self.color = color
        }
    }
    
    private func isRed(node: Node?) -> Bool {
        guard let node = node else {return false}
        return node.color == RED
    }
}
//: [Next](@next)

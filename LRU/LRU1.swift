//
//  main.swift
//  Test1
//
//  Created by GSW on 2021/11/17.
//

import Foundation

let o = LRU(capacity: 5)
o.put(key: "1", value: "One")
o.put(key: "2", value: "Two")
o.put(key: "3", value: "Three")
o.put(key: "4", value: "Four")
o.put(key: "5", value: "Five")
o.put(key: "6", value: "Six")
_ = o.get(key: "3")
o.description()

class LRU {
    
    private class LinkListNode: Equatable {
        let key: String
        var value: String
        var pre: LinkListNode?
        var next: LinkListNode?
        
        init(key: String, value: String) {
            self.key = key
            self.value = value
        }
    
        convenience init() {
            self.init(key: "", value: "")
        }
        
        static func == (lhs: LinkListNode, rhs: LinkListNode) -> Bool {
            return (lhs.key == rhs.value) && (lhs.value == lhs.value)
        }
    }
    
    let capacity: Int
    private var size: Int
    private let head: LinkListNode
    private let trail: LinkListNode
    private var cache: [String:LinkListNode] = [:]
    
    init(capacity: Int) {
        self.capacity = capacity
        size = 0
        head = LinkListNode()
        trail = LinkListNode()
        head.next = trail
        trail.pre = head
    }
    
    
    public func get(key: String) -> String? {
        guard let node = cache[key] else {
            return nil
        }
        moveToHead(node: node)
        return node.value
    }
    
    public func put(key: String, value: String) {
        guard let node = cache[key] else {
            let node = LinkListNode(key: key, value: value)
            cache[key] = node
            addToHead(node: node)
            size += 1
            if size > capacity {
                if let lastNode = removeLastNode() {
                    cache.removeValue(forKey: lastNode.key)
                }
                size -= 1
            }
            return
        }
        node.value = value
        moveToHead(node: node)
    }
    
    public func description() {
        var index: LinkListNode? = head
        var time = 0
        print("Description Start: ===========================")
        while index?.next != trail {
            index = index?.next
            time += 1
            print("Time: \(time), Key: \(index?.key ?? ""), Value: \(index?.value ?? "")")
            
        }
        print("Description End: ===========================")
    }
    
    private func removeLastNode() -> LinkListNode? {
        guard let lastNode = trail.pre else { return nil }
        lastNode.pre?.next = trail
        trail.pre = lastNode.pre
        return lastNode
    }
    
    private func addToHead(node: LinkListNode) {
        node.next = head.next
        node.pre = head
        head.next?.pre = node
        head.next = node
    }
    
    private func moveToHead(node: LinkListNode) {
        node.pre?.next = node.next
        node.next?.pre = node.pre
        addToHead(node: node)
    }
}


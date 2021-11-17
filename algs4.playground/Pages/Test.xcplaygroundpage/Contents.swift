//: [Previous](@previous)

import Foundation

class Tree {
    private class Node {
        let value: Int
        var left: Node?
        var right: Node?
        var N = 0
        init(value: Int) {
            self.value = value
        }
    }
    
    private var root: Node?
    
    enum PrintType {
        case dfs1(Bool)
        case dfs2(Bool)
        case dfs3(Bool)
        case bfs
        
        func description() -> String {
            switch self {
            case .dfs1(let recursive):
                return "前序 " + (recursive ? "递归" : "非递归")
            case .dfs2(let recursive):
                return "中序 " + (recursive ? "递归" : "非递归")
            case .dfs3(let recursive):
                return "后序 " + (recursive ? "递归" : "非递归")
            case .bfs:
                return "广度 "
            }
        }
    }
    
    
    public func add(value: Int) {
        root = add(node: root, value: value)
    }
    
    public func print(type: PrintType) {
        Swift.print("print type: \(type.description()).\n")
        switch type {
        case .dfs1(let recursive):
            recursive ? printdfs1_1(node: root) : printdfs1_2(node: root)
        case .dfs2(let recursive):
            recursive ? printdfs2_1(node: root) : printdfs2_2(node: root)
        case .dfs3(let recursive):
            recursive ? printdfs3_1(node: root) : printdfs3_2(node: root)
        case .bfs:
            printbfs(node: root)
        }
        Swift.print("\n")
    }
    
    private func printdfs1_1(node: Node?) {
        guard let node = node else {return}
        Swift.print(node.value, terminator: "")
        printdfs1_1(node: node.left)
        printdfs1_1(node: node.right)
    }
    private func printdfs1_2(node: Node?) {
        guard let node = node else {return}
        var stack = [Node]()
        stack.append(node)
        while !stack.isEmpty {
            if let current = stack.popLast() {
                Swift.print(current.value, terminator: "")
                if let right = current.right {
                    stack.append(right)
                }
                if let left = current.left {
                    stack.append(left)
                }
            }
        }
    }
    private func printdfs2_1(node: Node?) {
        guard let node = node else {return}
        printdfs2_1(node: node.left)
        Swift.print(node.value, terminator: "")
        printdfs2_1(node: node.right)
    }
    private func printdfs2_2(node: Node?) {
        guard let node = node else {return}
        var stack = [Node]()
        var targetNode: Node? = node
        while !stack.isEmpty || targetNode != nil {
            if let t = targetNode {
                stack.append(t)
                targetNode = targetNode?.left
            } else {
                if let current = stack.popLast() {
                    Swift.print(current.value, terminator: "")
                    if let right = current.right {
                        targetNode = right
                    }
                }
            }
        }
    }
    private func printdfs3_1(node: Node?) {
        guard let node = node else {return}
        printdfs3_1(node: node.left)
        printdfs3_1(node: node.right)
        Swift.print(node.value, terminator: "")
    }
    private func printdfs3_2(node: Node?) {
        guard let node = node else {return}
        var stack1 = [Node]()
        var stack2 = [Node]()
        stack1.append(node)
        while !stack1.isEmpty {
            let current = stack1.removeLast()
            stack2.append(current)
            if let left = current.left {
                stack1.append(left)
            }
            if let right = current.right {
                stack1.append(right)
            }
        }
        while !stack2.isEmpty {
            Swift.print(stack2.removeLast().value, terminator: "")
        }
        
    }
    private func printbfs(node: Node?) {
        guard let node = node else {return}
        var queue = [Node]()
        
        queue.append(node)
        while !queue.isEmpty {
            let current = queue.removeFirst()
            Swift.print(current.value, terminator: "")
            if let left = current.left {
                queue.append(left)
            }
            if let right = current.right {
                queue.append(right)
            }
        }
    }
        
    
    private func add(node: Node?, value: Int) -> Node? {
        guard let node = node else {return Node(value: value)}
        if value > node.value {
            node.right = add(node: node.right, value: value)
        } else if value < node.value {
            node.left = add(node: node.left, value: value)
        }
        return node
    }
    
}

//let tree = Tree()
//let a = [4,2,6,1,3,5,7,8,9]
//for value in a {
//    tree.add(value: value)
//}
//
//tree.print(type: .dfs1(true))
//tree.print(type: .dfs1(false))
//tree.print(type: .dfs2(true))
//tree.print(type: .dfs2(false))
//tree.print(type: .dfs3(true))
//tree.print(type: .dfs3(false))
//tree.print(type: .bfs)


//: [Next](@next)



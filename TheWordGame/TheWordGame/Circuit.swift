//
//  Circuit.swift
//  The Word Game
//
//  Created by Daniel McCrystal on 11/28/16.
//  Copyright © 2016 Lampshade Software. All rights reserved.
//

import Foundation

class Circuit<Element>: NSObject {
    
    fileprivate var current: Node<Element>?
    fileprivate var size: Int
    override init() {
        current = nil
        size = 0
    }
    func getCurrent() -> Element {
        return current!.value
    }
    func getSize() -> Int {
        return size
    }
    func insert(_ val: Element) {
        current = Node(after: current, value: val)
        size += 1
    }
    func remove() {
        if size == 0 {
            return
        }
        if size == 1 {
            current = nil
        } else {
            current!.previous!.next = current!.next
            current!.next!.previous = current!.previous
            _ = cycle()
        }
        size -= 1
    }
    func cycle() -> Element {
        let temp = current!
        current = current!.next
        return temp.value
    }
    
    func toString() -> String {
        var str = ""
        var pointer = current!
        str += "[ "
        repeat {
            print("\(pointer.value) ", terminator: "")
            str += String(describing: pointer.value) + " "
            pointer = pointer.next!
        } while pointer !== current!
        str += "]"
        return str
    }
}

class Node<Element> {
    var value: Element
    var next, previous: Node?
    init(after node:  Node?, value: Element) {
        self.value = value
        if node == nil {
            next = nil
            previous = nil
            next = self
            previous = self
        } else {
            next = node!.next
            node!.next!.previous = self
            previous = node!
            node!.next = self
        }
    }
}

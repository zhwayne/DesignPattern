//
//  Prototype.swift
//  DesignPattern
//
//  Created by Wayne on 2018/6/13.
//  Copyright © 2018年 张尉. All rights reserved.
//

import Foundation
// 原型模式，用于复制一个对象
// 比如 NSCopying 协议



struct ProtoTypePattern {}
extension ProtoTypePattern: RunCase {
    
    static func runCase() {
        
        let human = Human(name: "Jack")
        
        let cat = Cat()
        cat.name = "Mimi"
        cat.owner = human
        
        let anOtherCat = cat.clone()
        
        print(cat)
        print(anOtherCat)
    }
}


protocol Cloneable {
    func clone() -> Any
}

protocol Pet {
    var name: String? { get set }
    var owner: AnyObject? { get set }
}

class Cat: Pet, CustomStringConvertible {
    var name: String?
    weak var owner: AnyObject?
    
    var description: String {
        return "Cat<name: \(String(describing: name)), owner: \(String(describing: owner))>"
    }
}

class Human: CustomStringConvertible {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var description: String {
        return "Human<name: \(name)>"
    }
}

extension Cat: Cloneable {
    
    func clone() -> Any {
        
        let newCat = Cat()
        newCat.name = name
        newCat.owner = owner
        
        return newCat
    }
}


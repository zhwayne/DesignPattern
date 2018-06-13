//
//  Factory.swift
//  DesignPattern
//
//  Created by Wayne on 2018/6/13.
//  Copyright © 2018年 张尉. All rights reserved.
//

import Foundation
// 工厂模式
// 比如某个类生成实例的类方法

struct FactoryPattern: RunCase {
    
    static func runCase() {
        
        let appleFactory = AppleFactory()
        
        let iPadMini = appleFactory.makeComputer(.tablet("iPad Mini 2"))
        let MacBookPro = appleFactory.makeComputer(.laptop("MacBook Pro 2016"))
        
        iPadMini.launch()
        MacBookPro.launch()
        
        let xiaomiFactory = XiaomiFactory()
        
        let gameLaptop = xiaomiFactory.makeComputer(.laptop("小米游戏本"))
        
        gameLaptop.launch()
    }
}


class Computer {
    var manufacturer: String = ""
    var model: String = ""
    
    func launch() { }
}

class Laptop: Computer {
    override func launch() {
        print("Laptop(\(model), made by \(manufacturer)) launch.")
    }
}

class Tablet: Computer {
    override func launch() {
        print("Tablet(model: \(model), made by \(manufacturer)) launch.")
    }
}

enum ComputerType {
    case laptop(String)
    case tablet(String)
}

struct AppleFactory {
    
    func makeComputer(_ type: ComputerType) -> Computer {
        
        switch type {
        case .laptop(let model):
            let laptop = Laptop()
            laptop.manufacturer = "Apple Inc."
            laptop.model = model
            
            return laptop
            
        case .tablet(let model):
            let tablet = Tablet()
            tablet.manufacturer = "Apple Inc."
            tablet.model = model
            
            return tablet
        }
    }
}


struct XiaomiFactory {
    
    func makeComputer(_ type: ComputerType) -> Computer {
        
        switch type {
        case .laptop(let model):
            let laptop = Laptop()
            laptop.manufacturer = "Xiaomi Co., Ltd"
            laptop.model = model
            
            return laptop
            
        case .tablet(let model):
            let tablet = Tablet()
            tablet.manufacturer = "Xiaomi Co., Ltd"
            tablet.model = model
            
            return tablet
        }
    }
}

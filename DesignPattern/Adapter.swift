//
//  Adapter.swift
//  DesignPattern
//
//  Created by 张尉 on 2017/6/28.
//  Copyright © 2017年 张尉. All rights reserved.
//

import Foundation


/* 适配器模式用于将一个类的接口转变成另一个接口，让原本不兼容的接口可以合作无间. */
//  ╭---------------------------------------------------------------------------------------╮
//  | ◎ ○ ○ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  Object Adapter  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░|
//  +---------------------------------------------------------------------------------------+
//  |                                                                                       |
//  |                                                                                       |
//  |                                                                                       |
//  |    +----------+        +------------------+          +-------------------+            |
//  |    |  Client  |------->|     <Target>     |          |      Adaptee      |            |
//  |    +----------+        +------------------+          +-------------------+            |
//  |                        |                  |          |                   |            |
//  |                        |     request      |          |  specificRequest  |            |
//  |                        |                  |          |                   |            |
//  |                        +------------------+          +-------------------+            |
//  |                            ^                                  ^                       |
//  |                                                               |                       |
//  |                            |                  adaptee         |                       |
//  |                                      +------------------------+                       |
//  |                            |         |                                                |
//  |                                      |                                                |
//  |                            |         |                                                |
//  |                       +------------------+                                            |
//  |                       |     Adapter      |                                            |
//  |                       +------------------+                                            |
//  |                       |                  |         .-----------------------------.    |
//  |                       |     request  ○---+--------(    adaptee.specificRequest    )   |
//  |                       |                  |         `-----------------------------'    |
//  |                       +------------------+                                            |
//  |                                                                                       |
//  |                                                                                       |
//  |                                                                                       |
//  +---------------------------------------------------------------------------------------+
//
//
//
//  ╭---------------------------------------------------------------------------------------╮
//  | ◎ ○ ○ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  Class Adapter  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░|
//  +---------------------------------------------------------------------------------------+
//  |                                                                                       |
//  |                                                                                       |
//  |                                                                                       |
//  |    +----------+        +------------------+          +-------------------+            |
//  |    |  Client  |------->|     <Target>     |          |      Adaptee      |            |
//  |    +----------+        +------------------+          +-------------------+            |
//  |                        |                  |          |                   |            |
//  |                        |     request      |          |  specificRequest  |            |
//  |                        |                  |          |                   |            |
//  |                        +------------------+          +-------------------+            |
//  |                            ^                                  ^                       |
//  |                                                               |                       |
//  |                            |                                  |                       |
//  |                                      +------------------------+                       |
//  |                            |         |                                                |
//  |                                      |                                                |
//  |                            |         |                                                |
//  |                       +------------------+                                            |
//  |                       |     Adapter      |                                            |
//  |                       +------------------+                                            |
//  |                       |                  |         .-----------------------------.    |
//  |                       |     request  ○---+--------(     super.specificRequest     )   |
//  |                       |                  |         `-----------------------------'    |
//  |                       +------------------+                                            |
//  |                                                                                       |
//  |                                                                                       |
//  |                                                                                       |
//  +---------------------------------------------------------------------------------------+



struct AdapterPattern {}

extension AdapterPattern: RunCase {
    static func runCase() {
        
        let browser = Browser()
        browser.send(request: Request())
        browser.send(request: AnOtherRequestAdapter1(request: AnOtherRequest()))
        browser.send(request: AnOtherRequestAdapter2())
    }
}

private enum HTTPMethod {
    case post
    case get
}

private protocol HTTPRequest {
    var url: URL { get }
    var method: HTTPMethod { get }
}

private class Request: HTTPRequest {
    var url: URL { return URL(string: "https://www.zhwayne.com")! }
    var method: HTTPMethod { return .get }
}

private class AnOtherRequest {
    var urlString: String = "https://www.zhwayne.com"
    var methodString: String = "post"
}

/* 对象适配器 */
private class AnOtherRequestAdapter1: HTTPRequest {
    private let request: AnOtherRequest
    init(request: AnOtherRequest) {
        self.request = request
    }
    
    var url: URL { return URL(string: request.urlString)! }
    var method: HTTPMethod {
        if request.methodString == "get" {
            return .get
        } else {
            return .post
        }
    }
}

/* 类适配器 */
private class AnOtherRequestAdapter2: AnOtherRequest, HTTPRequest {
    var url: URL { return URL(string: urlString)! }
    var method: HTTPMethod {
        if methodString == "get" {
            return .get
        } else {
            return .post
        }
    }
}

private class Browser {
    func send(request: HTTPRequest) {
        print("send request: url<\"\(request.url)\">, method<\"\(request.method)\">.")
    }
}

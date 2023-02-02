//
//  StreamString.swift
//  honwoyomu
//
//  Created by gaoge on 2023/2/1.
//

let stream = AsyncStream<String> { continuation in
    continuation.yield("test")
}



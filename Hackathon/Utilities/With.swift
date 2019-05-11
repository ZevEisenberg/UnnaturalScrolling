//
//  With.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

func with<T>(_ t: T, transform: (inout T) throws -> Void) rethrows -> T {
    var t = t
    try transform(&t)
    return t
}

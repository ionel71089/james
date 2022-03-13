//
//  Util.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import Foundation

extension String: Error {}

extension Optional {
    func getOrThrow() throws -> Wrapped {
        if case let .some(value) = self {
            return value
        }
        
        throw "Optional was nil"
    }
}

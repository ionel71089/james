//
//  ExpansionState.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import Foundation


struct ExpansionState: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        do {
            let data = try rawValue.data(using: .utf8).getOrThrow()
            let state = try JSONDecoder().decode(ExpansionStateJSON.self, from: data)
            self.files = state.files
        } catch {
            print("error")
            return nil
        }
    }
    
    var rawValue: String { 
        do {
            let state = ExpansionStateJSON(files: files)
            let data = try JSONEncoder().encode(state)
            let string = try String(data: data, encoding: .utf8).getOrThrow()
            return string
        } catch {
            fatalError("Could not encode ExpansionState \(error)")
        }
    }
    
    private struct ExpansionStateJSON: Codable {
        let files: Bool
        
        internal init(files: Bool = true) {
            self.files = files
        }
    }    
    
    var files: Bool = false
    
    init() {
        files = true
    }
}


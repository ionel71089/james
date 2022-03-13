//
//  JamesApp.swift
//  James
//
//  Created by Ionel Lescai on 12.03.2022.
//

import SwiftUI

@main
struct JamesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
        }
    }
}

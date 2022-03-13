//
//  ContentView.swift
//  James
//
//  Created by Ionel Lescai on 12.03.2022.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedFile") var selectedFile: File.ID?
    
    var body: some View {
        NavigationView {
            Sidebar(selectedFile: $selectedFile)
                .frame(minWidth: 200)
            RequestsTable(selectedFile: $selectedFile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}


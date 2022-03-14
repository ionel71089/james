//
//  ContentView.swift
//  James
//
//  Created by Ionel Lescai on 12.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State var selectedFiles = Set<RequestFilter.ID>()
    
    var body: some View {
        NavigationView {
            Sidebar(selectedFiles: $selectedFiles)
                .frame(minWidth: 200)
            
            VSplitView {
                RequestsTable(selectedFile: $selectedFiles)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                TabView {
                    Text("Tab 1")
                        .tabItem {
                            Label("Details", systemImage: "")
                        }
                    
                    Text("Tab 2")
                        .tabItem {
                            Label("Timeline", systemImage: "clock")
                        }
                    
                    Text("Tab 3")
                        .tabItem {
                            Label("Chart", systemImage: "chart.bar")
                        }
                }
                .frame(maxWidth: .infinity, minHeight: 200, idealHeight: 200, maxHeight: .infinity)
                
                
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}


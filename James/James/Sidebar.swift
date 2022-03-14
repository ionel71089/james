//
//  Sidebar.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var model: Model
    
    @SceneStorage("expansionState") var expansionState = ExpansionState()
    @Binding var selectedFiles: Set<RequestFilter.ID>
    
    var body: some View {
        List(selection: $selectedFiles) {
            DisclosureGroup(isExpanded: $expansionState.files) {
                ForEach(model.files) { file in
                    Label(file.name, systemImage: file.systemImage)
                }
            } label: {
                Label("Files", systemImage: "doc.on.doc")
            }
            
            Section(header: Text("Requests by type")) {
                ForEach(model.otherRequest) { filter in
                    Label(filter.name, systemImage: filter.systemImage)
                }
            }
        }
    }
}


struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selectedFiles: .constant(.init()))
            .environmentObject(Model())
    }
}

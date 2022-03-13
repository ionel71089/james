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
    @Binding var selectedFile: File.ID?
    
    var body: some View {
        List(selection: $selectedFile) {
            DisclosureGroup(isExpanded: $expansionState.files) {
                ForEach(model.files) { file in
                    Label(file.name, systemImage: "doc")
                }
            } label: {
                Label("Files", systemImage: "doc.on.doc")
            }
        }
    }
}


struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selectedFile: .constant(nil))
            .environmentObject(Model())
    }
}

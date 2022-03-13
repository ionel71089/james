//
//  RequestsTable.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import SwiftUI

struct RequestsTable: View {
    @Binding var selectedFile: File.ID?
    @EnvironmentObject var model: Model
    
    var table: some View {
        Table(model.transactions) {
            TableColumn("Type", value: \.type.rawValue)
            TableColumn("Host", value: \.host)
            TableColumn("Path", value: \.host)
        }
    }
    
    var body: some View {
        table
            .navigationTitle("Requests")
            .navigationSubtitle("\(selectedFile?.description ?? "")")
    }
}

struct RequestsTable_Previews: PreviewProvider {
    static var previews: some View {
        RequestsTable(selectedFile: .constant(nil))
            .environmentObject(Model())
    }
}

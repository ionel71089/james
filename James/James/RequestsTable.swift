//
//  RequestsTable.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import SwiftUI

struct RequestsTable: View {
    @Binding var selectedFile: Set<RequestFilter.ID>
    @EnvironmentObject var model: Model
    
    var table: some View {
        //        Table(model.transactions) {
        //            TableColumn("Type", value: \.type.rawValue)
        //            TableColumn("Host", value: \.host)
        //            TableColumn("Path", value: \.host)
        //        }
        
        List(model.transactions) { transaction in
            HStack {
                Image(systemName: transaction.type.icon)
                Text(transaction.type.rawValue)
                Text(transaction.status)
                Text(transaction.response)
                if !transaction.json.isEmpty {
                    Text("JSON")
                }
                Text(transaction.start)
                Text(transaction.end)
            }
        }
    }
    
    var body: some View {
        table
            .navigationTitle("Requests")
    }
}

struct RequestsTable_Previews: PreviewProvider {
    static var previews: some View {
        RequestsTable(selectedFile: .constant(.init()))
            .environmentObject(Model())
    }
}

//
//  Model.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import Foundation

class Model: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var files: [File] = []
    
    init() {
        loadFile()
    }
    
    func loadFile() {
        do {
        let filePath = "/Users/ionel.lescai/projects/james/output.json"
        transactions = try .fromFile(path: URL(fileURLWithPath: filePath))
        let fileNames = Set(transactions
                                .filter { !$0.fileName.isEmpty }
                                .map { $0.fileName })
                                .sorted()
        files = fileNames.map { File(name: $0) }
        } catch {
            print(error)
        }
    }
}

struct Transaction: Identifiable {
    let id = UUID().uuidString
    
    enum RequestType: String, Decodable {
        case getUrl = "GET_URL"
        case upload  = "UPLOAD"
        case jobTracking = "JOB_TRACKING"
        case unknown = "UNKNOWN"
    }
    
    let type: RequestType
    let fileName: String
    let start: String
    let end: String
    let status: String
    let method: String
    let host: String
    let path: String
    let query: String
    let response: String
    let json: String
    let fileId: String
    let jobId: String
}

/// The file being uploaded in the requests, with its original name
struct File: Identifiable {
    let id = UUID().uuidString
    let name: String
}

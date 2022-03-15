//
//  Decoding.swift
//  
//
//  Created by Ionel Lescai on 15.03.2022.
//

import Foundation

struct CharlesSessionFile: Decodable {
    private var charlesSession: CharlesSession
    
    private struct CharlesSession: Decodable {
        var transaction: [TransactionDTO]
    }
    
    fileprivate struct TransactionDTO: Decodable {
        var type: Transaction.RequestType
        var fileName: String?
        var start: String
        var end: String
        var status: String
        var method: String
        var host: String
        var path: String?
        var query: String?
        var response: String
        var json: String?
        var fileId: String?
        var jobId: String?
        var jobStatus: String?
    }
    
    fileprivate static func fromFile(path: URL) throws -> [TransactionDTO] {
        let jsonDecoder = JSONDecoder()
        let data = try Data(contentsOf: path)
        let sessionFile = try jsonDecoder.decode(CharlesSessionFile.self, from: data)
        return sessionFile.charlesSession.transaction
    }
}

extension Array where Element == Transaction {
    public static func fromFile(path: URL) throws -> [Transaction] {
        try CharlesSessionFile
            .fromFile(path: path)
            .map {
                Transaction(type: $0.type,
                            fileName: $0.fileName ?? "",
                            start: $0.start,
                            end: $0.end,
                            status: $0.status,
                            method: $0.method,
                            host: $0.host,
                            path: $0.path ?? "",
                            query: $0.query ?? "",
                            response: $0.response,
                            json: $0.json ?? "",
                            fileId: $0.fileId ?? "",
                            jobId: $0.jobId ?? "",
                            jobStatus: $0.jobStatus ?? "")
            }
    }
}

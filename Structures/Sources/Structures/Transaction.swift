//
//  Transaction.swift
//  
//
//  Created by Ionel Lescai on 15.03.2022.
//

import Foundation

public struct Transaction: Identifiable {
    public let id = UUID().uuidString
    
    public enum RequestType: String, Decodable {
        case getUrl = "GET_URL"
        case upload  = "UPLOAD"
        case jobTracking = "JOB_TRACKING"
        case unknown = "UNKNOWN"
    }
    
    public let type: RequestType
    public let fileName: String
    public let start: String
    public let end: String
    public let status: String
    public let method: String
    public let host: String
    public let path: String
    public let query: String
    public let response: String
    public let json: String
    public let fileId: String
    public let jobId: String
    public let jobStatus: String
    
//    public init(type: Transaction.RequestType,
//                fileName: String,
//                start: String,
//                end: String,
//                status: String,
//                method: String,
//                host: String,
//                path: String,
//                query: String,
//                response: String,
//                json: String,
//                fileId: String,
//                jobId: String,
//                jobStatus: String) {
//        self.type = type
//        self.fileName = fileName
//        self.start = start
//        self.end = end
//        self.status = status
//        self.method = method
//        self.host = host
//        self.path = path
//        self.query = query
//        self.response = response
//        self.json = json
//        self.fileId = fileId
//        self.jobId = jobId
//        self.jobStatus = jobStatus
//    }
}

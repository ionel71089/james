//
//  Transaction.swift
//  
//
//  Created by Ionel Lescai on 15.03.2022.
//

import Foundation

public struct Transaction: Identifiable, Encodable {
    public let id = UUID().uuidString
    
    public enum RequestType: String, Codable {
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
    
    public enum CodingKeys: CodingKey {
        case type
        case fileName
        case start
        case end
        case status
        case method
        case host
        case path
        case query
        case response
        case json
        case fileId
        case jobId
        case jobStatus
    }
}

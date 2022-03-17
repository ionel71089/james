//
//  Model.swift
//  James
//
//  Created by Ionel Lescai on 13.03.2022.
//

import Foundation
import Structures

class Model: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var files: [RequestFilter] = []
    @Published var otherRequest: [RequestFilter] = []    
    @Published var jobTrackingData: [(String, Int)] = []
    @Published var jobStatus: [(String, Int)] = []
    
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
            files = fileNames.map { RequestFilter(name: $0, systemImage: "doc") }
            otherRequest = [
                RequestFilter(name: "Get url", systemImage: Transaction.RequestType.getUrl.icon),
                RequestFilter(name: "Upload", systemImage: Transaction.RequestType.upload.icon),
                RequestFilter(name: "Job tracking", systemImage: Transaction.RequestType.jobTracking.icon),
                RequestFilter(name: "User info", systemImage: "person"),
                RequestFilter(name: "Token refresh", systemImage: "key"),
            ]
            
            makeJobTrackingData()
            
        } catch {
            print(error)
        }
    }
    
    func makeJobTrackingData() {
        var jobIdCount = [String: Int]()
        var jobStatusCount = [String: Int]()
        
        transactions
            .filter { $0.type == .jobTracking }
            .map { ($0.jobId, $0.jobStatus) }
            .forEach { (jobId, jobStatus) in
                jobIdCount[jobId, default: 0] += 1
                jobStatusCount[jobStatus, default: 0] += 1
            }
        let maximumRequests = max(jobIdCount.values.max() ?? 0, 10)
        
        var jobData = [(String, Int)]()
        for value in 1...maximumRequests {
            let jobs = jobIdCount.filter { $0.value == value }
            jobData.append(("\(value)", jobs.count))
        }
        
        jobTrackingData = jobData
        jobStatus = [
            ("JobNotStarted", jobStatusCount["JobNotStarted", default: 0]),
            ("JobInProgress", jobStatusCount["JobInProgress", default: 0]),
            ("JobDone", jobStatusCount["JobDone", default: 0]),
        ]
    }
}

extension Transaction.RequestType {
    var icon: String {
        switch self {
            case .getUrl:
                return "square"
            case .upload:
                return "circle"
            case .jobTracking:
                return "diamond"
            case .unknown:
                return "questionmark.circle"
        }
    }
}

/// The file being uploaded in the requests, with its original name
struct RequestFilter: Identifiable {
    let id = UUID().uuidString
    let name: String
    let systemImage: String
}

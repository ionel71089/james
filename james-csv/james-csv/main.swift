//
//  main.swift
//  james-csv
//
//  Created by Ionel Lescai on 15.03.2022.
//

import Foundation
import Structures
import CodableCSV

let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])

do {
    let transactions: [Transaction] = try .fromFile(path: input)
    let encoder = CSVEncoder {
        $0.headers = [
            "type",
            "fileName",
            "start",
            "end",
            "status",
            "method",
            "host",
            "path",
            "query",
            "response",
            "json",
            "fileId",
            "jobId",
            "jobStatus"
        ]
    }
    try encoder.encode(transactions, into: output)
} catch {
    print(error)
}

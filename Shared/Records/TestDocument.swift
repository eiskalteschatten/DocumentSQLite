//
//  TestDocument.swift
//  DocumentSQLite
//
//  Created by Alex Seifert on 25.05.22.
//

import Foundation
import GRDB

struct TestDocument: Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var text: String
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

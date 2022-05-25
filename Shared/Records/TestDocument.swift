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
    var createdAt: Date?
    var updatedAt: Date?
    
    fileprivate enum Columns {
        static let text = Column(CodingKeys.text)
        static let createdAt = Column(CodingKeys.createdAt)
        static let updatedAt = Column(CodingKeys.updatedAt)
    }
    
    mutating func save(_ db: Database) throws {
        if id == nil {
            createdAt = Date()
        }
        updatedAt = Date()
        try performSave(db)
    }
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

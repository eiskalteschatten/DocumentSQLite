//
//  Model.swift
//  DocumentSQLite
//
//  Created by Alex Seifert on 25.05.22.
//

import Foundation
import GRDB

struct TextModel: Codable, FetchableRecord, PersistableRecord {
    var text: String
}

func createTextModelTable() {
    do {
        try inMemoryDBQueue.write { db in
            try db.create(table: "text") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("text", .text)
            }
        }
    } catch {
        // TODO: actually throw the error
//            throw CocoaError(error)
    }
}

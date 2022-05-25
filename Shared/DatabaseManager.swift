//
//  DB.swift
//  DocumentSQLite
//
//  Created by Alex Seifert on 25.05.22.
//

import Foundation
import GRDB

final class DatabaseManager {
    static let shared = DatabaseManager()
    var inMemoryDBQueue = DatabaseQueue()
    
    private init () {}
    
    func setup() throws {
        try DatabaseManager.migrator.migrate(inMemoryDBQueue)
    }
    
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createTextTable") { db in
            try db.create(table: "text") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("text", .text)
            }
        }

        return migrator
    }
}

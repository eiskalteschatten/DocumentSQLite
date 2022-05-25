//
//  DB.swift
//  DocumentSQLite
//
//  Created by Alex Seifert on 25.05.22.
//

import Foundation
import GRDB

final class DB {
    static let shared = DB()
    var inMemoryDBQueue = DatabaseQueue()
    
    private init () {
        createTables()
//        migrate()
    }
    
    private func createTables() {
        do {
            var migrator = DatabaseMigrator()
            migrator.registerMigration("createTextTable") { db in
                try db.create(table: "text") { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("text", .text)
                }
            }
            
            try migrator.migrate(inMemoryDBQueue)
        } catch {
            // TODO: actually throw the error
            print(error)
        }
    }
    
    private func migrate() {
        // TODO
    }
}

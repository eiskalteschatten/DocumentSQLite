//
//  DocumentSQLiteDocument.swift
//  Shared
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI
import UniformTypeIdentifiers
import GRDB

extension UTType {
    static var exampleDB: UTType {
        UTType(importedAs: "com.example.sqlite")
    }
}

struct DocumentSQLiteDocument: FileDocument {
    var testDocument: TestDocument
    
    init() {
        testDocument = TestDocument(text: "")
        
        do {
            try DatabaseManager.shared.setup()
            try DatabaseManager.shared.inMemoryDBQueue.write { db in
                try testDocument.insert(db)
            }
        } catch {
            // TODO: actually throw the error
            print(error)
        }
    }
    
    static var readableContentTypes: [UTType] { [.exampleDB] }

    init(configuration: ReadConfiguration) throws {
        testDocument = TestDocument(text: "")
        
        guard let dbPath = configuration.file.filename
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        do {
            try DatabaseQueue(path: dbPath).backup(to: DatabaseManager.shared.inMemoryDBQueue)
            try DatabaseManager.shared.inMemoryDBQueue.read { db in
                if let fetchedModel = try TestDocument.fetchOne(db) {
                    testDocument = fetchedModel
                }
            }
        } catch {
            // TODO: actually throw the error
            print(error)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return SqliteFileWrapper(fromDatabaseQueue: DatabaseManager.shared.inMemoryDBQueue)
    }
}

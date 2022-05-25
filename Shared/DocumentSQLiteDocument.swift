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
    var textModel: TextModel
    
    init() {
        textModel = TextModel(text: "")
        
        do {
            try DatabaseManager.shared.setup()
            try DatabaseManager.shared.inMemoryDBQueue.write { db in
                try textModel.insert(db)
            }
        } catch {
            // TODO: actually throw the error
            print(error)
        }
    }
    
    static var readableContentTypes: [UTType] { [.exampleDB] }

    init(configuration: ReadConfiguration) throws {
        textModel = TextModel(text: "")
        
        guard let dbPath = configuration.file.filename
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        do {
            try DatabaseQueue(path: dbPath).backup(to: DatabaseManager.shared.inMemoryDBQueue)
            try DatabaseManager.shared.inMemoryDBQueue.read { db in
                if let fetchedModel = try TextModel.fetchOne(db) {
                    textModel = fetchedModel
                }
                else {
                    try DatabaseManager.shared.inMemoryDBQueue.write { db in
                        try textModel.insert(db)
                    }
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

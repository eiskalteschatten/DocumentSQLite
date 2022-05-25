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
    var inMemoryDBQueue = DatabaseQueue()
    var textModel: TextModel
    
    init() {
        textModel = TextModel(text: "")
    }
    
    static var readableContentTypes: [UTType] { [.exampleDB] }

    init(configuration: ReadConfiguration) throws {
        textModel = TextModel(text: "")
        
        guard let dbPath = configuration.file.filename
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        do {
            try DatabaseQueue(path: dbPath).backup(to: inMemoryDBQueue)
            try inMemoryDBQueue.read { db in
                if let fetchedModel = try TextModel.fetchOne(db) {
                    textModel = fetchedModel
                }
            }
        } catch {
            // TODO: actually throw the error
//            throw CocoaError(error)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return SqliteFileWrapper(fromDatabaseQueue: inMemoryDBQueue)
    }
}

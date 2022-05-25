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

    static var readableContentTypes: [UTType] { [.exampleDB] }

    init(configuration: ReadConfiguration) throws {
        guard let dbPath = configuration.file.filename
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        do {
            try DatabaseQueue(path: dbPath).backup(to: inMemoryDBQueue)
        } catch {
//            throw CocoaError(error)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return SqliteFileWrapper(fromDatabaseQueue: inMemoryDBQueue)
    }
}

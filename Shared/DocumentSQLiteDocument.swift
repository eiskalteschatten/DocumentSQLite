//
//  DocumentSQLiteDocument.swift
//  Shared
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleDB: UTType {
        UTType(importedAs: "com.example.sqlite")
    }
}

struct DocumentSQLiteDocument: FileDocument {
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.exampleDB] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        .appendingPathComponent("HeroesDatabase.sqlite")
        
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}

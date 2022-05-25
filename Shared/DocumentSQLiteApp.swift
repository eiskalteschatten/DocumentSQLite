//
//  DocumentSQLiteApp.swift
//  Shared
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

@main
struct DocumentSQLiteApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DocumentSQLiteDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}

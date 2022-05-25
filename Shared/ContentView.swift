//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DocumentSQLiteDocument

    var body: some View {
        TextEditor(text: Binding(get: {
            document.testDocument.text
        }, set: {
            document.testDocument.text = $0
            
            do {
                try DatabaseManager.shared.inMemoryDBQueue.write { db in
                    try document.testDocument.save(db)
                }
            } catch {
                // TODO: throw error
                print(error)
            }
        }))
//        Text("test")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DocumentSQLiteDocument()))
    }
}

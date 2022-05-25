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
        TextEditor(text: $document.testDocument.text)
//        Text("test")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DocumentSQLiteDocument()))
    }
}

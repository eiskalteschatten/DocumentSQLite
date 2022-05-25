//
//  SqliteFileWrapper.swift
//  DocumentSQLite
//
//  Created by Alex Seifert on 25.05.22.
//

import Foundation
import GRDB

// See: https://stackoverflow.com/questions/66359387/swiftui-filedocument-using-sqlite-and-grdb

class SqliteFileWrapper: FileWrapper {
    var databaseQueue: DatabaseQueue

    init (fromDatabaseQueue databaseQueue: DatabaseQueue) {
        self.databaseQueue = databaseQueue
        super.init(regularFileWithContents: "".data(using: .utf8)!)
    }

    required init?(coder inCoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func write(
        to url: URL,
        options: FileWrapper.WritingOptions = [],
        originalContentsURL: URL?
    ) throws {
        let destination = try DatabaseQueue(path: url.path)
        do {
            try databaseQueue.backup(to: destination)
        } catch {
            // TODO: actually throw the error
//            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
}

//
//  Model.swift
//  DocumentSQLite
//
//  Created by Alex Seifert on 25.05.22.
//

import Foundation
import GRDB

struct TextModel: Codable, FetchableRecord, PersistableRecord {
  var text: String
}

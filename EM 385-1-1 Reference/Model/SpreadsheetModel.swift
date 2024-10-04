//
//  SpreadsheetModel.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 8/19/24.
//

import Foundation
import RealmSwift
import Realm

class SpreadsheetModel: Object {
    @Persisted var tableID: String
    @Persisted var tableName: String
    @Persisted var numCol: Int?
    @Persisted var numRow: Int?
    @Persisted var colWidth: List<Int>
    @Persisted var rowHeight: List<Int>
    @Persisted var freezeCol: Int?
    @Persisted var freezeRow: Int?
    @Persisted var mergeCells: List<MergeRange>
    @Persisted var table: Table?
    
    convenience init(tableID: String = "Table X-X", tableName: String = "Table Description", numCol: Int? = nil, numRow: Int? = nil, colWidth: List<Int>, rowHeight: List<Int>, freezeCol: Int? = 0, freezeRow: Int? = 1, table: Table?) {
        self.init()
        self.tableID = tableID
        self.tableName = tableName
        self.numCol = numCol
        self.numRow = numRow
        self.colWidth = colWidth
        self.rowHeight = rowHeight
        self.freezeCol = freezeCol
        self.freezeRow = freezeRow
        self.table = table
    }
}

class Table: EmbeddedObject {
    @Persisted var tableRows: List<Rower>
}

class Rower: EmbeddedObject {
    @Persisted var row: List<Celler>
}

class Celler: EmbeddedObject {
    @Persisted var text: String?
    @Persisted var highlight: Bool
    
    convenience init(text: String? = nil) {
        self.init()
        self.text = text
        self.highlight = false
    }
}

class MergeRange: EmbeddedObject {
    @Persisted var row1: Int
    @Persisted var col1: Int
    @Persisted var row2: Int
    @Persisted var col2: Int
}

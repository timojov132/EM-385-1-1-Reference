import RealmSwift
import SpreadsheetView
import Realm
import UIKit

class CreateSpreadsheet {
    let realm = try! Realm()
    let tableNames = ["Table 02-1 Minimum Toilet Facilites", "Table 02-2 Minimum Toilet Facilities (Construction Sites)", "Table 05-1 Eye and Face Protector Selection Guide", "Table 05-2 Required Shades for Filter Lenses Glasses in Welding, Cutting, Brazing and Soldering", "Table 05-3 Settings for Noise Measuring Equipment", "Table 05-4 Non-DoD Continuous Noise Exposures (OSHA Standard)", "Table 05-5 Hand and Arm Protection", "Table 05-6 Standards for Electrical Protective Equipment", "Table 05-7 Arc Flash Protective Clothing and PPE", "Table 06-1 Occupational Dose Limits", "Table 06-2 Laser Safety Goggle Optical Density Requirements", "Table 06-3 Abrasive Blasting Media Silica Substitutes", "Table 07-1 Minimum Lighting Requirements", "Table 08-1 Accident Prevention Sign Requirements", "Table 08-2 Accident Prevention Color Coding", "Table 08-3 Identification of Piping Systems", "Table 09-1 Maximum Allowable Size of Portable Containers and Tanks for Flammable Liquids", "Table 09-2 Outside Storage of LP-Gas Containers and Cylinders - Minimum Distances", "Table 09-3 Temporary Heating Device Clearances", "Table 09-4 Fire Extinguisher Distribution", "Table 11-1 Minimum Clearance from Energized Overhead Electric Lines", "Table 11-2 Hazardous (Classified) Locations", "Table 11-3 AC Live Work Minimum Approach Distance", "Table 15-1 Minimum Thickness of Chain Links", "Table 16-1 Minimum Clearance from Energized Overhead Electric Lines", "Table 16-2 Minimum Clearance Distance from Energized Overhead Electric Lines While   Traveling with No Load", "Table 19-1 Fire Extinguisher Requirements for Launches-Motorboats", "Table 21-1 Safety Net Distances", "Table 22-1 Form Scaffolds (Minimum Design Criteria for Wooden Bracket Form Scaffolds)", "Table 22-2 Minimum Dimensions for Horse Scaffold Members", "Table 25-1 Soil Classification", "Table 28-1 Erection Bridging for Short Span Joists", "Table 28-2 Erection Bridging for Long Span Joists", "Table 29-1 Energy Ratio and Peak Particle Velocity Formula", "Table 03-1 Requirements for Basic First Aid Unit Package", "Table 30-1 Umbilical Markings", "Table G-1 Dive Team Composition", "Table G-2 Dive Team Composition", "Table G-3 Dive Team Composition", "Table G-4 Dive Team Composition", "Table G-5 Dive Team Composition"]
    
    let screenWidth = Int(UIScreen.main.bounds.width)
    init() {
        do {
            try realm.write {
                for name in self.tableNames {
                    print(name)
                    var maxCol = 0
                    var tableData = tsv(name: name)
                    var bables = []
                    var colWidth: [Int] = []
                    var rowHeight: [Int] = []
                    var rowNum = 0
                    let title = tableData[0][0]
                    let subtitle = tableData[1][0]
                    tableData.remove(at: 0)
                    tableData.remove(at: 0)
                    if tableData.isEmpty {
                        return
                    }
                    for _ in tableData[0] {
                        colWidth.append(0)
                    }
                    for row in tableData {
                        rowHeight.append(0)
                        var bow = []
                        var col = 0
                        var rowH: Double = 0
                        for text in row {
                            print("Row: \(rowNum)    Column: \(col)")
                            print(text)
                            let celL = ["text": text, "highlight": false]
                            let textLen = Double(text.count / 60)
                            if textLen > rowH {
                                rowH = textLen
                            }
                            switch textLen {
                            case 0..<1:
                                colWidth[col] = getLargest(newVal: 160, oldVal: colWidth[col])
                            case 1..<2:
                                colWidth[col] = getLargest(newVal: 320, oldVal: colWidth[col])
                            case 2..<3:
                                colWidth[col] = getLargest(newVal: 480, oldVal: colWidth[col])
                            default:
                                colWidth[col] = screenWidth
                            }
                            col = 1 + col
                            bow.append(celL)
                        }
                        while bow.count < colWidth.count {
                            let celL = ["text": "", "highlight": false]
                            bow.append(celL)
                        }
                        if bow.count > maxCol {
                            maxCol = bow.count
                        }
                        switch rowH {
                        case 0..<3:
                            rowHeight[rowNum] = 80
                        case 3..<4.5:
                            rowHeight[rowNum] = 120
                        case 4.5..<6:
                            rowHeight[rowNum] = 160
                        case 6..<7.5:
                            rowHeight[rowNum] = 200
                        case 7.5..<9:
                            rowHeight[rowNum] = 240
                        case 9..<10.5:
                            rowHeight[rowNum] = 280
                        default:
                            rowHeight[rowNum] = 280
                        }
                        let bows = ["row": bow]
                        rowNum = rowNum + 1
                        bables.append(bows)
                    }
                    let mergeCells = merger(name: name)
                    print("Final: \(mergeCells)")
                    let spreadsheetModel = SpreadsheetModel(value: ["tableID": title, "tableName": subtitle, "colWidth": colWidth, "rowHeight": rowHeight, "numCol": maxCol, "numRow": bables.count, "mergeCells": mergeCells, "table": ["tableRows": bables]])
                    realm.add(spreadsheetModel)
                }
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    func tsv(name: String) -> [[String]] {
        guard let url = Bundle.main.url(forResource: name, withExtension: "txt", subdirectory: "TextFiles") else { print("Failed to get content"); return [["Table 8-1"],["Accident Prevention Sign Requirements"],["Type", "Purpose", "Design"]] }
        var result: [[String]] = []
        let content = try! String(contentsOf: url, encoding: String.Encoding(rawValue: NSUTF8StringEncoding))
        let rows = content.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: "\t")
            result.append(columns)
        }
        if result.last?.first == "" || result.last?.first == "\r" {
            result.removeLast()
        }
        return result
    }
    
    func cellIsEmpty(name: String) -> [[Bool]] {
        var table = tsv(name: name)
        table.remove(at: 0)
        table.remove(at: 0)
        var result: [[Bool]] = []
        var i = 0
        for row in table {
            var j = 0
            var rowB: [Bool] = []
            for cell in row {
                if table[i][j] == "\r" || table[i][j] == "" {
                    rowB.append(true)
                } else {
                    rowB.append(false)
                }
                j = j + 1
            }
            result.append(rowB)
            i = i + 1
        }
        print(result)
        return result
    }
    
    func merger(name: String) -> [[Int]] {
        let table = cellIsEmpty(name: name)
        var result: [[Int]] = []
        var row = table.count - 1
        var col = table[0].count - 1
        while row >= 0 {
            while col >= 0 {
                if table[row][col] {
                    var i = row
                    var j = col
                    var row1 = 0
                    var col1 = 0
                    let row2 = row
                    let col2 = col
//                    print("Above: \(table[row - 1][col] ? "Is Empty" : "Is Not Empty") \nLeft: \(table[row][col - 1] ? "Is Empty" : "Is Not Empty")")
                    if row == 0 {
                        while j >= 0 {
                            if !table[i][j] {
                                row1 = i
                                col1 = j
                            }
                            j = j - 1
                        }
                    } else if col == 0 {
                        while i >= 0 {
                            if !table[i][j] {
                                row1 = i
                                col1 = j
                            }
                            i = i - 1
                        }
                    } else {
                        switch (table[i][j - 1], table[i - 1][j]) {
                        case (true, true) :
                            while j >= 0 {
                                if !table[i][j] {
                                    row1 = i
                                    col1 = j
                                }
                                j = j - 1
                            }
                        case (false, true) :
                            j = j - 1
                            row1 = i
                            col1 = j
                        case (true, false) :
                            i = i - 1
                            row1 = i
                            col1 = j
                        case (false, false) :
                            j = j - 1
                            row1 = i
                            col1 = j
                        }
                    }
                    result.append([row1, col1, row2, col2])
                }
                col = col - 1
            }
            row = row - 1
        }
        print(result)
        for merge in result {
            if merge != result[0] {
                for compare in result {
                    if merge[0] >= compare[0] && merge[1] >= compare[1] && merge[2] <= compare[2] && merge[3] <= compare[3] {
                        result.removeAll(where: {$0 == merge})
                    }
                }
            }
        }
        print("after")
        print(result)
        return result
    }
    func getLargest(newVal: Int, oldVal: Int) -> Int {
        if newVal > oldVal {
            return newVal
        } else {
            return oldVal
        }
    }
}

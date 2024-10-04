import UIKit
import SpreadsheetView
import RealmSwift

class SpreadsheetViewController: UIViewController {

    private let spreadsheetView = SpreadsheetView()
    let realm = try! Realm()
    var realmTable: Results<SpreadsheetModel>?
    var table: Table?
    let data = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmTable = realm.objects(SpreadsheetModel.self)
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        spreadsheetView.register(MyTableCell.self, forCellWithReuseIdentifier: MyTableCell.identifier)
        let name = data.string(forKey: "SpreadsheetFile") ?? "TABLE 08-1 "
        realmTable = realm.objects(SpreadsheetModel.self).filter("tableID CONTAINS '\(name)'")
        let title = realmTable![0].tableID
        let subtitle = realmTable![0].tableName
        self.navigationItem.setTitle(title: title, subtitle: subtitle)
        view.addSubview(spreadsheetView)
        guard let stable = realmTable?[0].table else {
            print("No table data found")
            table = nil
            return
        }
        table = stable
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spreadsheetView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height - 100)
    }

}

extension SpreadsheetViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: MyTableCell.identifier, for: indexPath) as! MyTableCell
        guard var text = table?.tableRows[indexPath.row].row[indexPath.section].text else {
            cell.setup(with: "")
            print("Failure")
            return cell }
        text.replace("\\n", with: "\n")
        cell.setup(with: text)
        return cell
    }
    
    
//    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
//        spreadsheetView.deselectItem(at: indexPath, animated: true)
//        guard let cell = spreadsheetView.cellForItem(at: indexPath) as? MyTableCell else { return }
//        let label = cell.getLabel()
//        print(label.text)
//        if !cell.isTouched {
//            cell.bounds = CGRect(x: 0, y: 0, width: 480, height: 240)
//        } else {
//            cell.bounds = CGRect(x: 0, y: 0, width: 160, height: 80)
//        }
//        cell.isTouched = !cell.isTouched
//    }
}

extension SpreadsheetViewController: SpreadsheetViewDataSource {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow column: Int) -> CGFloat {
        guard let rowHeight = realmTable?[0].rowHeight[column] else { return 80 }
        return CGFloat(rowHeight)
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        guard let colWidth = realmTable?[0].colWidth[column] else { return 160 }
        let column = (CGFloat(colWidth) > view.frame.width) ? view.frame.width : CGFloat(colWidth)
        return CGFloat(column)
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        guard let colNum = realmTable![0].numCol else { return 1 }
        return  colNum
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        guard let rowNum = realmTable![0].numRow else { return 1 }
        return  rowNum
    }
    
    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        var merge: [CellRange] = []
        guard var mergeCells = realmTable?[0].mergeCells else {
            print("No merge")
            return []
        }
        if !mergeCells.isEmpty {
            print("Yes Merge")
            var i = mergeCells.count - 1
            while i >= 0 {
                var range = (realmTable?[0].mergeCells[i])!
                let firstCell = CellRange(from: (row: mergeCells[i].row1, column: mergeCells[i].col1), to: (row: mergeCells[i].row2, column: mergeCells[i].col2))
                print(firstCell)
                merge.append(firstCell)
                i = i - 1
            }
        }
        return merge
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return (realmTable?[0].freezeRow) ?? 1
    }
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return (realmTable?[0].freezeCol) ?? 0
    }
}

class MyTableCell: Cell {
    
    private let label = UILabel()
    static let identifier = "MyTableCell"
    var isTouched = false
    
    public func setup(with text: String) {
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        contentView.addSubview(label)
    }
    
    public func setup(with text: String, _ alignment: NSTextAlignment) {
        label.text = text
        label.textAlignment = alignment
        label.numberOfLines = 0
        contentView.addSubview(label)
    }
    
    public func getLabel() -> UILabel {
        return self.label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        
    }
}

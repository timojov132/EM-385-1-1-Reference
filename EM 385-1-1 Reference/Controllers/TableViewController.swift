//
//  TableViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 4/3/24.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController {
    
    let realm = try! Realm()
    var realmTable: Results<SpreadsheetModel>?
    let data = UserDefaults()
    
    
    @IBOutlet weak var tablesView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmTable = realm.objects(SpreadsheetModel.self).sorted(by: \.tableID)
        tablesView.dataSource = self
        tablesView.delegate = self
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablesView.deselectRow(at: indexPath, animated: true)
        let title = (realmTable?[indexPath.row].tableID) ?? "TABLE 8-1 "
        data.set(title, forKey: "SpreadsheetFile")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpreadsheetViewController")
        self.show(vc, sender: nil)
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = realmTable!.count as Int
            return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = realmTable?[indexPath.row].tableID
        content.secondaryText = realmTable?[indexPath.row].tableName
        cell.contentConfiguration = content
        
        return cell
    }
    

}

//
//  TableViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 4/3/24.
//

import UIKit

class FormViewController: UIViewController {
    
    var table: [String] = ["Table 1", "Table 2", "Table 3"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

extension FormViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = table[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(table[indexPath.row])
    }
}

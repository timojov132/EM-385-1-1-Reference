//
//  TableViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 4/3/24.
//

import UIKit

class TableViewController: UIViewController {
    
    var table: [String] = ["Table 1", "Table 2", "Table 3"]
    
    
    
    @IBOutlet weak var chapterView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterView.dataSource = self
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableItemCell", for: indexPath)
        
        cell.textLabel?.text = table[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(table[indexPath.row])
    }
}

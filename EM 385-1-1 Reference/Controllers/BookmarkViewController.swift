//
//  BookmarkViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 5/20/24.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    var table: [String] = ["Bookmark 1", "Bookmark 2", "Bookmark 3"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionItemCell", for: indexPath)
        
        cell.textLabel?.text = table[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(table[indexPath.row])
    }
}

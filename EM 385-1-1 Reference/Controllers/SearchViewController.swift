//
//  SearchViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 5/20/24.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    let realm = try! Realm()
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchBarUI: UISearchBar!
    var searchResults: Results<Reference>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarUI.becomeFirstResponder()
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    
    
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.placeholder = "No search"
        }
        let searchWords = searchText.components(separatedBy: " ")
        var predicate = ""
        for word in searchWords {
            if searchWords[0] == word {
                predicate = "content CONTAINS '\(word)'"
            } else {
                predicate = predicate + " && content CONTAINS '\(word)'"
            }
        }
//        searchResults = realm.objects(Reference.self).where {
//            $0.content.contains("\(searchText)", options: .caseInsensitive)
//        }
        searchResults = realm.objects(Reference.self).filter(predicate).distinct(by: ["content"])
            self.searchTable.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTable.deselectRow(at: indexPath, animated: true)
        let chapterNum = searchResults?[indexPath.row].chapter ?? "01"
        let sectionNum = searchResults?[indexPath.row].section ?? "A"
        let sections = realm.objects(Reference.self).filter("chapter == '\(chapterNum)' && topic == null").distinct(by: ["content"])
        ChapterSettings.updateSettings(chapterNum, sections, sectionNum)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        self.show(vc, sender: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = searchResults?[indexPath.row].content
        cell.contentConfiguration = content
        return cell
    }
    
    
}

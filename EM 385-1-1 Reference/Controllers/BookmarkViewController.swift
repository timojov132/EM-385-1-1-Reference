//
//  BookmarkViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 5/20/24.
//

import UIKit
import RealmSwift
import SwipeCellKit

class BookmarkViewController: UIViewController {
    
    var table: [String] = ["Bookmark 1", "Bookmark 2", "Bookmark 3"]
    var bookmarks: Results<Reference>?
    let realm = try! Realm()
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarks = realm.objects(Reference.self).filter("bookmark == TRUE")
        bookmarkTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        bookmarks = realm.objects(Reference.self).filter("bookmark == TRUE")
        bookmarkTableView.reloadData()
    }
}

extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return bookmarks?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkItemCell", for: indexPath) as! SwipeTableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = bookmarks?[indexPath.row].content ?? "No Bookmarks"
        cell.contentConfiguration = content
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapterNum = bookmarks?[indexPath.row].chapter ?? "01"
        let sectionNum = bookmarks?[indexPath.row].section ?? "A"
        let sections = realm.objects(Reference.self).filter("chapter == '\(chapterNum)' && topic == null").distinct(by: ["content"])
        ChapterSettings.updateSettings(chapterNum, sections, sectionNum)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        self.show(vc, sender: nil)
    }
}

extension BookmarkViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            try! self.realm.write{
                self.bookmarks?[indexPath.row].setValue(false, forKey: "bookmark")
            }
            self.bookmarkTableView.reloadData()
            }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()

        options.expansionStyle = .destructive(automaticallyDelete: false)
        return options
    }
    
}

//
//  ChapterViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/20/24.
//
import UIKit
import RealmSwift

class ChapterViewController: UIViewController {
    
    var refData: Results<Reference>?
    var refDataPrev: Results<Reference>?
    var refDataNext: Results<Reference>?
    var cellIdentifier = ""
    let realm = try! Realm()
    
    func loadReferenceData() {
        let section = ChapterSettings.sectionLet[ChapterSettings.currentSec]
        let chapter = ChapterSettings.currentChapter
        refData = realm.objects(Reference.self).filter("chapter == '\(chapter)' AND section == '\(section)'").distinct(by: ["content"])
        if ChapterSettings.currentSec > 0 {
            let prev = ChapterSettings.sectionLet[ChapterSettings.currentSec - 1]
            refDataPrev = realm.objects(Reference.self).filter("chapter == '\(chapter)' AND section == '\(prev)'").distinct(by: ["content"])
        }
        if ChapterSettings.currentSec < ChapterSettings.sectionLet.count - 1 {
            let next = ChapterSettings.sectionLet[ChapterSettings.currentSec + 1]
            refDataNext = realm.objects(Reference.self).filter("chapter == '\(chapter)' AND section == '\(next)'").distinct(by: ["content"])
        }
    }
    
    func updateReferenceData(_ currentPresenter: Int) {
        switch currentPresenter {
        case 0:
            if ChapterSettings.currentView == 1 {
                prev()
            } else if ChapterSettings.currentView == 2 {
                next()
            }
        case 1:
            if ChapterSettings.currentView == 2 {
                prev()
            } else if ChapterSettings.currentView == 0 {
                next()
            }
        case 2:
            if ChapterSettings.currentView == 0 {
                prev()
            } else if ChapterSettings.currentView == 1 {
                next()
            }
        default: print("Invalid Presenter")
        }
        ChapterSettings.currentView = currentPresenter
    }
    func next() {
        if ChapterSettings.currentSec < ChapterSettings.sectionLet.count - 1 {
            ChapterSettings.currentSec = ChapterSettings.currentSec + 1
        }
        loadReferenceData()
    }
    func prev() {
        if ChapterSettings.currentSec > 0 {
            ChapterSettings.currentSec = ChapterSettings.currentSec - 1
        }
        loadReferenceData()
    }
    
}

extension ChapterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReferenceCell
        
        var content = cell.defaultContentConfiguration()
        content.text = refData?[indexPath.row].content ?? "No Data Found"
        if refData?[indexPath.row].bookmark != true {
            cell.bookmark.setImage(UIImage(named: "bookmark"), for: .normal)
        } else {
            cell.bookmark.setImage(UIImage(named: "bookmark.fill"), for: .normal)
        }
        if refData?[indexPath.row].topic == nil {
            cell.backgroundColor = .yellow
        } else if refData?[indexPath.row].refOne == nil{
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .clear
        }
        cell.contentConfiguration = content
        
        return cell
    }
}

extension ChapterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = tableView.cellForRow(at: indexPath)?.contentConfiguration as? UIListContentConfiguration
        let text = content?.text
        let bookmarkUpdate = refData?.first(where: ({$0.content == text}))
        try! realm.write{
            let bookmark = !(bookmarkUpdate?.bookmark ?? true)
            bookmarkUpdate?.setValue(bookmark, forKey: "bookmark")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class ReferenceCell: UITableViewCell {
    @IBOutlet var bookmark: UIButton!
    
}

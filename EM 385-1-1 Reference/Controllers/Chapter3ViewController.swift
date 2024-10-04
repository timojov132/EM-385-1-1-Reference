//
//  ChapterViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/20/24.
//
import UIKit

class Chapter3ViewController: ChapterViewController {

    
    @IBOutlet weak var ref3View: UITableView!
    
    
    override func viewDidLoad() {
        ref3View.dataSource = self
        ref3View.delegate = self
        cellIdentifier = "Ref3ItemCell"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateReferenceData(2)
        ref3View.reloadData()
    }
}
//
//extension Chapter3ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        ref3View.deselectRow(at: indexPath, animated: true)
//        let bookmarkUpdate = refData?[indexPath.row]
//        print(bookmarkUpdate?.bookmark)
//        try! realm.write{
//            if bookmarkUpdate?.bookmark == nil {
//                bookmarkUpdate?.bookmark = true
//            } else {
//                bookmarkUpdate?.bookmark = !(bookmarkUpdate?.bookmark ?? true)
//            }
//        }
//    }
//}

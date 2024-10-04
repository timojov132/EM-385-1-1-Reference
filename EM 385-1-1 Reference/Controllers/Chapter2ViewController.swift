//
//  ChapterViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/20/24.
//
import UIKit

class Chapter2ViewController: ChapterViewController {

    
    @IBOutlet weak var ref2View: UITableView!
    
    
    override func viewDidLoad() {
        ref2View.dataSource = self
        ref2View.delegate = self
        cellIdentifier = "Ref2ItemCell"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateReferenceData(1)
        ref2View.reloadData()
    }
}
//
//extension Chapter2ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
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

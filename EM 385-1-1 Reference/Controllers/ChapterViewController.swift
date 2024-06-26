//
//  ChapterViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/20/24.
//
import UIKit
import RealmSwift

class ChapterViewController: UIViewController {
    
    @IBOutlet weak var ref1View: UITableView!
    
    var refData: Results<Sec21Formatted>?
    let realm = try! Realm()
    var sectionsLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"]
    var currentSection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReferenceData()
        ref1View.dataSource = self
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.view.addGestureRecognizer(swipeRight)
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func loadReferenceData() {
        let chapterModel = ChapterModel()
        refData = realm.objects(Sec21Formatted.self).filter("section == '\(chapterModel.sectionLet[chapterModel.currentSec])'")
    }
//    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizer.Direction.right:
//                //right view controller
//                let newViewController = ChapterTwoViewController()
//                newViewController.currentSection = currentSection - 1
//                performSegue(withIdentifier: "updateSection", sender: nil)
////                self.navigationController?.pushViewController(newViewController, animated: true)
//            case UISwipeGestureRecognizer.Direction.left:
//                //left view controller
//                let newViewController = ChapterTwoViewController()
//                print(sectionsLetters[currentSection])
//                newViewController.currentSection = currentSection + 1
//                performSegue(withIdentifier: "updateSection", sender: nil)
//                //self.navigationController?.pushViewController(newViewController, animated: true)
//            default:
//                break
//            }
//        }
//    }
}

extension ChapterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ref1ItemCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = refData?[indexPath.row].content ?? "No Data Found"
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(refData?[indexPath.row].content ?? "No Data Found")
    }

}


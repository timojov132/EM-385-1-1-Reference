//
//  MenuViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 5/20/24.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    
    let realm = try! Realm()
    let data = UserDefaults()
    
    @IBOutlet weak var versionButton: UIButton!
    
    override func viewDidLoad() {
        let dictionaryData = DictionaryLoader()
        super.viewDidLoad()
        dictionaryData.loadDefinitions()
        print(data.bool(forKey: "2014Book"))
        //data.setValue(true, forKey: "2014Book")
        if data.bool(forKey: "2014Book") {
            versionButton.setTitle("2014 Version", for: .normal)
        } else {
            versionButton.setTitle("2024 Version", for: .normal)
        }
        let bookmarkUpdate = realm.objects(Reference.self).filter("bookmark == false")
        
        
    }
    @IBAction func versionControl(_ sender: UIButton) {
        let book = data.bool(forKey: "2014Book")
        print(book)
        data.setValue(!book, forKey: "2014Book")
        if book {
            versionButton.setTitle("2024 Version", for: .normal)
        } else {
            versionButton.setTitle("2014 Version", for: .normal)
        }
    }
    
    
}

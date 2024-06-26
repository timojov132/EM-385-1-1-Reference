//
//  MenuViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 5/20/24.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        let dictionaryData = DictionaryLoader()
        super.viewDidLoad()
        dictionaryData.loadDefinitions()
        
    }
}

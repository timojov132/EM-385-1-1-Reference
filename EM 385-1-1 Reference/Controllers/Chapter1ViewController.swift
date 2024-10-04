//
//  ChapterViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/20/24.
//
import UIKit

class Chapter1ViewController: ChapterViewController {
    
    @IBOutlet weak var ref1View: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref1View.dataSource = self
        ref1View.delegate = self
        loadReferenceData()
        cellIdentifier = "Ref1ItemCell"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateReferenceData(0)
        ref1View.reloadData()
    }
}


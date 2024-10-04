//
//  TableViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 4/3/24.
//

import UIKit
import PDFKit

class FormViewController: UIViewController {
    
    var table = [["Figure 1-1", "Figure 1-1.2"], ["Figure 1-2"], ["Figure 5-1"], ["Figure 6-1"], ["Figure 8-1"], ["Figure 8-2"], ["Figure 8-3"], ["Figure 8-4"], ["Figure 8-5"], ["Figure 8-6"], ["Figure 8-7"], ["Figure 8-8"], ["Figure 8-9"], ["Figure 15-1"], ["Figure 15-2"], ["Figure 15-3"], ["Figure 15-4"], ["Figure 16-1", "Figure 16-1.2", "Figure 16-1.3"], ["Figure 16-2"], ["Figure 16-3"], ["Figure 16-4"], ["Figure 21-1"], ["Figure 21-2"], ["Figure 21-3"], ["Figure 21-4", "Figure 21-4.2"], ["Figure 21-5"], ["Figure 21-6"], ["Figure 21-7"], ["Figure 22-1"], ["Figure 22-2"], ["Figure 22-3"], ["Figure 25-1"], ["Figure 25-2"], ["Figure 28-1"], ["Figure 28-2"], ["Figure 28-3", "Figure 28-3.2", "Figure 28-3.3"], ["Figure 28-4"], ["Figure 28-5"], ["Figure 29-1"], ["Figure 29-2"], ["Figure 34-1"], ["Figure B-1"], ["Figure F-1", "Figure F-2.2"], ["Figure F-2"], ["Figure F-3", "Figure F-3.2", "Figure F-3.3"]]
    var image: [UIImage?] = []
    let pdfView = PDFView()
    var pdfDoc = PDFDocument()
    
    @IBOutlet weak var formView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        formView.dataSource = self
        formView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PDFViewController
        destinationVC.pdfDoc = self.pdfDoc
    }
}

extension FormViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = table[indexPath.section][0]
        cell.contentConfiguration = content
        
        return cell
    }
}

extension FormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        image = []
        formView.deselectRow(at: indexPath, animated: true)
        for name in table[indexPath.section] {
            image.append(UIImage(named: name))
        }
        let newDoc = PDFDocument()
        var i = 0
        for image in image {
            guard let page = PDFPage(image: image!) else {
                return
            }
            newDoc.insert(page, at: i)
            i += 1
        }
        pdfDoc = newDoc
        self.performSegue(withIdentifier: "GoToPDF", sender: self)
        
    }
}

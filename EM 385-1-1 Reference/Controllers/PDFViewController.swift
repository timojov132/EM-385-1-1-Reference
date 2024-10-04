//
//  PDFViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 8/1/24.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    let pdfView = PDFView()
    var pdfDoc: PDFDocument?
    var testCon = "This is a test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Loaded")
        view.addSubview(pdfView)
        print(testCon)
        print(pdfDoc?.pageCount ?? "No Pages Found")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View Appeared")
        pdfView.document = pdfDoc
//        if pdfDoc === testDoc {
//            print("Doc not loaded")
//        } else {
//            print(pdfDoc.pageCount)
//            print(pdfView.document?.pageCount)
//        }
        view.insertSubview(pdfView, at: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("View Bounds Set")
        pdfView.frame = view.bounds
    }
    
    //guard let url = Bundle.main.url(forResource: "Figure 1-1.1", withExtension: ".png")
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

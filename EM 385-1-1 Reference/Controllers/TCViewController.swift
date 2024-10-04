//
//  ChapterViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/20/24.
//
import UIKit
import RealmSwift

struct ChapterSection {
    let chapSections: Results<Reference>
    var isOpened: Bool = false
    
    init(sections: Results<Reference>, isOpened: Bool = false) {
        self.chapSections = sections
        self.isOpened = isOpened
    }
}

class TCViewController: UIViewController {
    
    @IBOutlet weak var tcView: UITableView!
    
    let realm = try! Realm()
    var chapterSections: [ChapterSection] = []
    let chapterNames = ["SECTION 1 Program Management","SECTION 2 Sanitation","SECTION 3 Medical and First Aid","SECTION 4 Temporary Facilities","SECTION 5 Personal Protective and Safety Equipment","SECTION 6 Hazardous or Toxic Agents and Environments","SECTION 7 Lighting","SECTION 8 Accident Prevention Signs","SECTION 9 Fire Prevention and Protection","SECTION 10 Welding and Cutting","SECTION 11 Electrical","SECTION 12 Control of Hazardous Energy","SECTION 13 Hand and Power Tools","SECTION 14 Material Handling, Storage and Disposal","SECTION 15 Rigging","SECTION 16 Load Handling Equipment (LHE)","SECTION 17 Conveyors","SECTION 18 Vehicles, Machinery and Equipment","SECTION 19 Floating Plant and Marine Activities","SECTION 20 Pressurized Equipment and Systems","SECTION 21 Fall Protection","SECTION 22 Work Platforms and Scaffolding","SECTION 23 Demolition, Renovation and Re-Occupancy","SECTION 24 Safe Access","SECTION 25 Excavation and Trenching","SECTION 26 Underground Construction (Tunnels), Shafts and Caissons","SECTION 27 Concrete, Masonry, Roofing and Residential Construction","SECTION 28 Steel Erection","SECTION 29 Blasting","SECTION 30 Diving Operations","SECTION 31 Tree Maintenance and Removal","SECTION 32 Airfield and Aircraft Operations","SECTION 33 Hazardous Waste Operations and Emergency Response (HAZWOPER)","SECTION 34 Confined Space Entry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chapters = realm.objects(Reference.self).distinct(by: ["chapter"]).sorted(by: \.chapter)
        let sections = realm.objects(Reference.self).where({$0.topic == nil}).distinct(by: ["content"])
        for item in chapters {
            let tableSections = ChapterSection(sections: sections.where({$0.chapter == item.chapter}))
            chapterSections.append(tableSections)
        }
        tcView.dataSource = self
        tcView.delegate = self
    }
    
}

extension TCViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chapterNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chapterSections[section].isOpened {
            return (chapterSections[section].chapSections.count) + 1
        }
        
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.row == 0 {
            content.text = chapterNames[indexPath.section]
            cell.backgroundColor = .clear
        } else {
            
            content.text = "     " + chapterSections[indexPath.section].chapSections[indexPath.row - 1].content
            cell.backgroundColor = .systemGray6
        }
        cell.contentConfiguration = content
        return cell
    }
    
}

extension TCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathSection = indexPath.section + 1
        tcView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            chapterSections[indexPath.section].isOpened = !chapterSections[indexPath.section].isOpened
            tcView.reloadSections([indexPath.section], with: .none)
        } else {
            if indexPath.section < 9 {
                let stringChapter = "0" + (String(indexPathSection))
                ChapterSettings.updateSettings(stringChapter, chapterSections[indexPath.section].chapSections, indexPath.row - 1)
            } else {
                let stringChapter = (String(indexPathSection))
                ChapterSettings.updateSettings(stringChapter, chapterSections[indexPath.section].chapSections, indexPath.row - 1)
            }
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            vc.navigationItem.setTitle(title: chapterNames[indexPath.section], subtitle: "")
            self.show(vc, sender: nil)
        }
    }
}

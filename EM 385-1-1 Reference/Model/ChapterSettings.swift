
import Foundation
import RealmSwift

struct ChapterSettings {
    static var currentSec = 0
    static var sectionLet: [String] = []
    static var currentView = 0
    static var currentChapter = "01"
    
    static func updateSettings(_ chapter: String, _ sections: Results<Reference>, _ sectionNum: Int) {
        sectionLet = []
        ChapterSettings.currentChapter = chapter
        for item in sections {
            sectionLet.append(item.section)
        }
        ChapterSettings.currentSec = sectionNum
    }
    
    static func updateSettings(_ chapter: String, _ sections: Results<Reference>, _ sectionNum: String){
        sectionLet = []
        ChapterSettings.currentChapter = chapter
        for item in sections {
            sectionLet.append(item.section)
        }
        ChapterSettings.currentSec = sectionLet.firstIndex {$0 == sectionNum} ?? 1
        print(ChapterSettings.currentSec)
    }
}

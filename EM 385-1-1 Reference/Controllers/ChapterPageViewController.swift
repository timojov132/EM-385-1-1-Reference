import UIKit

class ChapterPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var chapterVC = [ChapterViewController]()
    
//    required init?(coder: NSCoder) {
//           super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageVC()
    }
    
    func configurePageVC() {
        if let pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chapter1ViewController") as? ChapterViewController {
            chapterVC.append(pageVC)
        }
        if let pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chapter2ViewController") as? ChapterViewController {
            chapterVC.append(pageVC)
        }
        if let pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chapter3ViewController") as? ChapterViewController {
            chapterVC.append(pageVC)
        }
//        let page1VC = ChapterViewController("A", "B", "B", cellID: "Ref1ItemCell")
//        let page2VC = ChapterViewController("B", "C", "A", cellID: "Ref2ItemCell")
//        let page3VC = ChapterViewController("C", "D", "B", cellID: "Ref3ItemCell")
//        chapterVC.append(page1VC)
//        chapterVC.append(page2VC)
//        chapterVC.append(page3VC)
        self.setViewControllers([chapterVC[0]], direction: .forward, animated: false, completion: nil)
        self.delegate = self
        self.dataSource = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
        if ChapterSettings.currentSec == 0 { return nil }
        
        guard let cur = chapterVC.firstIndex(of: viewController as! ChapterViewController) else { return nil }
        
        switch cur {
        case 0:
            return chapterVC[2]
        case 1:
            return chapterVC[0]
        case 2:
            return chapterVC[1]
        default: return chapterVC[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if ChapterSettings.currentSec >= ChapterSettings.sectionLet.count - 1 { return nil }
        
        guard let cur = chapterVC.firstIndex(of: viewController as! ChapterViewController) else { return nil }
        
        switch cur {
        case 0:
            return chapterVC[1]
        case 1:
            return chapterVC[2]
        case 2:
            return chapterVC[0]
        default: return chapterVC[0]
        }
    }
    
}

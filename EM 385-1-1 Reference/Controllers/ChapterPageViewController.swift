//
//  ChapterPageViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 6/24/24.
//

import UIKit

class ChapterPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageVC()
    }
    func configurePageVC() {
//        guard let first = myControllers.first else {
//            return }
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let chapterVC = ChapterViewController()
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([chapterVC], direction: .forward, animated: true, completion: nil)
        present(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = ChapterViewController()
        let chapterModel = ChapterModel()
        if chapterModel.currentSec > 0 {
            chapterModel.currentSec = chapterModel.currentSec - 1
        }
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = ChapterViewController()
        let chapterModel = ChapterModel()
        if chapterModel.currentSec < chapterModel.sectionLet.count - 1 {
            chapterModel.currentSec = chapterModel.currentSec + 1
        }
        return vc
    }
    
}

//
//  SettingsViewController.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 5/20/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let data = UserDefaults()
    
    @IBOutlet weak var darkMode: UIButton!
    @IBAction func waiverButton(_ sender: UIButton) {
    }
    @IBAction func appearanceButton(_ sender: UIButton) {
        let alertController = UIAlertController (title: "Leaving the App", message: "Go to Settings?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        let lightMode = data.bool(forKey: "LightMode")
        data.set(!lightMode, forKey: "LightMode")
        if lightMode {
            darkMode.titleLabel?.text = "Light Mode"
        } else {
            darkMode.titleLabel?.text = "Dark Mode"
        }
        print(data.bool(forKey: "LightMode"))
    }
    @IBAction func tutorialButton(_ sender: UIButton) {
    }
    @IBAction func referencesButton(_ sender: UIButton) {
        if let url = NSURL(string: "https://www.kugan.com/em385") {
            UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
        }
    }
    @IBAction func trainingsButton(_ sender: UIButton) {
        
        if let url = NSURL(string: "https://www.kugan.com") {
            UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
        }
    }
}

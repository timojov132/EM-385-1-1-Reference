//
//  AppDelegate.swift
//  EM 385-1-1 Reference
//
//  Created by Kugan Panchadaram on 4/3/24.
//

import UIKit
import RealmSwift

@main

class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "No URL")
        let realm = try! Realm()
        let URLString = Realm.Configuration.defaultConfiguration.fileURL?.absoluteString
        let URLlength = URLString!.count - 13
        var configURL = URLString?.prefix(URLlength)
        let textURL = String(configURL! + "final.realm")
        print(textURL)
        let realmURL = URL(string: textURL)
        var realmConfig = Realm.Configuration.defaultConfiguration
        realmConfig.fileURL = realmURL
        let realmFinal = try! Realm(configuration: realmConfig)
        try! realmFinal.write{
            let referenceO = realm.objects(Reference.self)
            for item in referenceO {
                var referenceF = Reference(value: ["chapter": item.chapter, "section": item.section, "topic": item.topic, "refOne": item.refOne, "refTwo": item.refTwo, "refThree": item.refThree, "content": item.content, "hightlight": item.highlight, "bookmark": item.bookmark])
                realmFinal.add(referenceF)
            }
        }
//        let spreadSheetDelete = realm.objects(SpreadsheetModel.self)
//        try! realm.write{
//            realm.delete(spreadSheetDelete)
//        }
//        let _ = CreateSpreadsheet()
//        let zeference = realm.objects(Zeference.self)
//        try! realm.write{
//            let bookmarks = realm.objects(Zeference.self)
//            bookmarks.setValue(false, forKey: "bookmark")
//            for item in zeference {
//                var reference = Reference(value: ["chapter": item.chapter, "section": item.section, "topic": item.topic, "refOne": item.refOne, "refTwo": item.refTwo, "refThree": item.refThree, "content": item.content, "hightlight": item.highlight, "bookmark": item.bookmark])
//                realm.add(reference)
//            }
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


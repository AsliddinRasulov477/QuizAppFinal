//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/23/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import CoreData
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
            LocalizationSystem.shared.locale = Locale(identifier: UserDefaults.standard.string(forKey: "AppleLanguage") ?? Locale.current.identifier)
            
            if LocalizationSystem.shared.locale != Locale(identifier: "uz") && LocalizationSystem.shared.locale != Locale(identifier: "uz-Cyrl") {
                LocalizationSystem.shared.locale = Locale(identifier: "ru")
            }
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        Util.shared.copyDatabase(dbName: "tests.db")
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
    
    func createTabbar()->UITabBarController {
           let tabbar = UITabBarController()
           tabbar.viewControllers = [UINavigationController(rootViewController: createHoemeVC()), UINavigationController(rootViewController: createSettingsVC())]
           return tabbar
       }
       
       func createHoemeVC()->HomeController {
           let vc = HomeController()
        vc.tabBarItem = UITabBarItem(title: "home".localized, image: UIImage(named: "home.fill"), selectedImage: UIImage(named: "home.fill"))
           return vc
       }
       func createSettingsVC()->SettingsViewController {
           let vc = SettingsViewController()
        vc.tabBarItem = UITabBarItem(title: "setting".localized, image: UIImage(named: "settings.fill"), selectedImage: UIImage(named: "settings.fill"))
           return vc
       }
    
    
}


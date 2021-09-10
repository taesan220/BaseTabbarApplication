//
//  AppDelegate.swift
//  BaseTabbarApplication
//
//  Created by Taesan Kim on 2021/09/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//MARK: - Global Variation
    
    static let shared = AppDelegate()
    
    var window: UIWindow?

    
//MARK: - Life Cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        }
        
        return true
    }

    
//MARK: - Common Methods
    func topViewController() -> UIViewController {
        var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
        
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!
        }
        
        return topController
    }
}

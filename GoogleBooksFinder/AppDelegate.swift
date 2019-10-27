//
//  AppDelegate.swift
//  GoogleBooksFinder
//
//  Created by Maksim Chizhavko on 10/24/19.
//  Copyright © 2019 Maksim Chizhavko. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Set custom URL scheme to turn on google auth system
//        Enter your client ID here
        GIDSignIn.sharedInstance().clientID = ""
//        Set new ROOT VC
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AuthorizationVC()
        window?.makeKeyAndVisible()
        
        return true
    }
    


}

extension AppDelegate {
   static var shared: AppDelegate {
      return UIApplication.shared.delegate as! AppDelegate
   }
var rootViewController: AuthorizationVC {
      return window!.rootViewController as! AuthorizationVC
   }
}

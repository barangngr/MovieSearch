//
//  AppDelegate.swift
//  MovieSearch
//
//  Created by Atlas Mac on 8.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import UIKit
import SwiftyBeaver
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        SwiftyBeaver.setupConsole()
        let platform = SBPlatformDestination(appID: "Ybn1JL",
                                             appSecret: "Nq5o8egnu7alExxQlafvhqsvfxsqRuwh",
                                             encryptionKey: "jg3W5fgB8qnjymHs9TrjfjoykywryBXv")
        SwiftyBeaver.addDestination(platform)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // Override point for customization after application launch.
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


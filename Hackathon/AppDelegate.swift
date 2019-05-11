//
//  AppDelegate.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let vc = RootViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return true
    }

}


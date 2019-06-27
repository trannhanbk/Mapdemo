//
//  AppDelegate.swift
//  MapViewDemo
//
//  Created by Nhan Tran D on 6/13/19.
//  Copyright © 2019 MBA0145. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }
}

extension AppDelegate {
    func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        let homvc = UserLocationViewController()
        window?.rootViewController = homvc
    }
}

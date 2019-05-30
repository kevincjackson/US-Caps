//
//  AppDelegate.swift
//  US Caps
//
//  Created by Kevin Jackson on 2/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var worldStateController = WorldStateController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navVC = window?.rootViewController as! UINavigationController
        let compVC = navVC.topViewController as! ListViewController
        compVC.worldStateController = worldStateController
        
        return true
    }
}


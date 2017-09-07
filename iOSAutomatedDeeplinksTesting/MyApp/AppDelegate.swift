//
//  AppDelegate.swift
//  MyApp
//
//  Created by Blaz Merela on 27/08/2017.
//  Copyright © 2017 Blaz Merela. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    // For demonstration purposes only
    return (UIApplication.shared.keyWindow?.rootViewController as! TabBarController).route(url)
  }
}

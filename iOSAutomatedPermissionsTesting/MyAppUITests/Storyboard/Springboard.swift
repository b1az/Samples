//
//  Springboard.swift
//  MyApp
//
//  Created by Blaz Merela on 06/09/2017.
//  Copyright © 2017 Blaz Merela. All rights reserved.
//

import XCTest

final class Springboard {
  static let springboard = XCUIApplication(privateWithPath: nil, bundleID: "com.apple.springboard")!

  class func deleteMyApp() {
    XCUIApplication().terminate()

    // Resolve the query for the SpringBoard rather than launching it
    springboard.resolve()

    let icon = springboard.icons[myAppName]
    XCTAssert(icon.isHittable)

    // Bring up the little "X" button to delete the app
    icon.press(forDuration: 1.3)

    // The little "X" button is seems not exposed directly
    let xButtonCoordinate = CGVector(dx: (icon.frame.minX + 3) / springboard.frame.maxX,
                                     dy: (icon.frame.minY + 3) / springboard.frame.maxY)
    // Delete the app
    springboard.coordinate(withNormalizedOffset: xButtonCoordinate).tap()
    springboard.alerts.buttons["Delete"].tap()

    // Stop icons from jiggling
    XCUIDevice.shared().press(.home)
  }

  private class var myAppName: String {
    // XCUIApplication().path example:
    // "/Users/{me}/Library/Developer/Xcode/DerivedData/MyApp-{someID}/Build/Products/Debug-iphonesimulator/MyApp.app"
    let appName = XCUIApplication().path
      .components(separatedBy: "/").last!
      .components(separatedBy: ".").dropLast()
    return Array(appName).first!
  }

}

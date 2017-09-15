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
  static let settings = XCUIApplication(privateWithPath: nil, bundleID: "com.apple.Preferences")!
  static let settingsIcon = springboard.icons["Settings"]

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

  private class func openMyAppSectionInSettings() {
    openSettings()

    let appCell = settings.tables.staticTexts[myAppName]

    func scrollToSettingsBottom() {
      // Will do even on the heighest device, as long as there aren't too many apps in Settings
      settings.swipeUp()
      settings.swipeUp()
    }

    func scrollToSettingsBottom_shouldBeWorkingAlternative() {
      // [Xcode 8.3.3, iOS 10.3]
      // For some reason, below approach errors out with
      // "Multiple matches found for "MyApp" StaticText."
      for _ in 1...10 where !appCell.isHittable {
        settings.swipeUp()
      }
    }

    func scrollToSettingsBottom_alternative2() {
      let tableBottom = settingsTable.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 1.0))
      let scrollVector = CGVector(dx: 0.0, dy: -30.0)
      tableBottom.press(forDuration: 0.5, thenDragTo: tableBottom.withOffset(scrollVector))
    }

    scrollToSettingsBottom()
    appCell.tap()
  }

  private class func openSettings() {
    // Make sure home screen is frontmost
    XCUIApplication().terminate()

    // Go to SpringBoard's first screen
    XCUIDevice.shared().press(.home)
    Thread.sleep(forTimeInterval: 0.5)
    XCTAssert(settingsIcon.isHittable)

    // Launch Settings.app from a known state
    settings.terminate()

    settingsIcon.tap()
  }

  private class var settingsTable: XCUIElement {
    return settings.tables.element(boundBy: 0)
  }

}

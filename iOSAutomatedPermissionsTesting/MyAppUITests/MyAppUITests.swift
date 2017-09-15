//
//  MyAppUITests.swift
//  MyAppUITests
//
//  Created by Blaz Merela on 06/09/2017.
//  Copyright © 2017 Blaz Merela. All rights reserved.
//

import XCTest

class MyAppUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    Springboard.deleteMyApp()
    super.tearDown()
  }

  func testAllowingNotifications() {
    requestNotificationsPermissionsWith(user: .allowing)
    // verify the state
    Springboard.turnNotifications(.off)
    // verify the state
  }

  func testDisallowingNotifications() {
    requestNotificationsPermissionsWith(user: .disallowing)
    // verify the state
    Springboard.turnNotifications(.on)
    // verify the state
  }

  private enum UserResponse {
    case allowing, disallowing
  }

  private func requestNotificationsPermissionsWith(user response: UserResponse) {
  }
}

//
//  DeeplinkTests.swift
//  MyAppUITests
//
//  Created by Blaz Merela on 27/08/2017.
//  Copyright © 2017 Blaz Merela. All rights reserved.
//

import XCTest

class DeeplinkTests: XCTestCase {
  
  let helperApp = XCUIApplication(bundleIdentifier: "org.merela.HelperApp")

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testTab1() {
    verify(deeplink: "tab1", with: {
      XCUIApplication().tabBars.buttons["First"].isSelected &&
        XCUIApplication().tables.element(boundBy: 0).cells.element(matching: .cell, identifier: "First cell").isHittable
    })
  }

  func testTab1Row1() {
    verify(deeplink: "tab1/row1", with: { XCUIApplication().staticTexts["1st row details"].isHittable })
  }

  func testTab1Row2() {
    verify(deeplink: "tab1/row2", with: { XCUIApplication().staticTexts["2nd row details"].isHittable })
  }

  func testTab2() {
    verify(deeplink: "tab2", with: { XCUIApplication().tabBars.buttons["Second"].isSelected })
  }

  private func verify(deeplink: String, with assertion: () -> Bool) {
    XCTContext.runActivity(named: "Tap deeplink '\(deeplink)' in helper-app") { _ in
      helperApp.activate()
      helperApp.buttons[deeplink].tap()
    }
    XCTAssert(assertion())
  }

}

//
//  Route.swift
//  MyApp
//
//  Created by Blaz Merela on 27/08/2017.
//  Copyright © 2017 Blaz Merela. All rights reserved.
//

import Foundation

enum Route {
  case tab1(cell: Int?)
  case tab2

  init?(from url: URL) {
    guard url.scheme == Bundle.main.bundleIdentifier else {
      return nil
    }
    // For expediency simply match on host + path.
    // Better approach: https://github.com/ijoshsmith/swift-deep-linking
    switch (url.host ?? "") + url.path {
    case "tab1":
      self = .tab1(cell: nil)
    case "tab1/row1":
      self = .tab1(cell: 1)
    case "tab1/row2":
      self = .tab1(cell: 2)
    case "tab2":
      self = .tab2
    default:
      return nil
    }
  }
}

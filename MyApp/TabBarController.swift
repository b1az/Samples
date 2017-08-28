import UIKit

class TabBarController: UITabBarController {
  func route(_ url: URL) -> Bool {
    guard let route = Route(from: url) else {
      return false
    }
    switch route {
    case .tab1(let cell):
      if let cell = cell {
        switch cell {
        case 1:
          let vc = UIStoryboard.Main.instantiateViewController(withIdentifier: "DetailVC1")
          present(vc, animated: false)
        case 2:
          let vc = UIStoryboard.Main.instantiateViewController(withIdentifier: "DetailVC2")
          present(vc, animated: false)
        default:
          return false
        }
      } else {
        selectedIndex = 0
      }
    case .tab2:
      selectedIndex = 1
    }
    return true
  }

}

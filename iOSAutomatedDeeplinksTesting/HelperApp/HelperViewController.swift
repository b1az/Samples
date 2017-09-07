import UIKit

class HelperViewController: UIViewController {

  @IBOutlet weak var stackView: UIStackView!

  let myAppBundleId = "org.merela.MyApp"

  override func viewDidLoad() {
    super.viewDidLoad()

    let deeplinks = [
      "tab1",
      "tab1/row1",
      "tab1/row2",
      "tab2",
      ]

    _ = deeplinks.map { deeplink in
      let button = UIButton(type: .system)
      button.setTitle(deeplink, for: .normal)
      button.addTarget(self, action: #selector(openDeeplink), for: .touchUpInside)
      stackView.addArrangedSubview(button)
    }
  }

  @objc
  func openDeeplink(_ button: UIButton) {
    guard let buttonTitle = button.title(for: .normal),
      let url = URL(string: "\(myAppBundleId)://\(buttonTitle)") else {
        fatalError("Invalid deeplink given")
    }
    UIApplication.shared.open(url)
  }

}

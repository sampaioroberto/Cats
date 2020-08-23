import UIKit

final class ViewControllerSpy: UIViewController {

    var showedViewController: UIViewController?

    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        self.showedViewController = vc
    }
}

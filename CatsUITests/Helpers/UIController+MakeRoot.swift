import UIKit

extension UIViewController {
    func makeRoot() {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.rootViewController = self
    }
}

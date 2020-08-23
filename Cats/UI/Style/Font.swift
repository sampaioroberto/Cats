import UIKit

extension UIFont {
    static func medium(weight: Weight = .medium) -> UIFont {
        UIFont.systemFont(ofSize: 14, weight: weight)
    }

    static func big(weight: Weight = .medium) -> UIFont {
        UIFont.boldSystemFont(ofSize: 18)
    }
}

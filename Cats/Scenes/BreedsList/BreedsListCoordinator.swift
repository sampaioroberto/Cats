import UIKit

protocol BreedsListCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class BreedsListCoordinator {
    weak var viewController: UIViewController?
}

extension BreedsListCoordinator: BreedsListCoordinating { }

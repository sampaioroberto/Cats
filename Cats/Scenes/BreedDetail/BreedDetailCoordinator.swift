import UIKit

protocol BreedDetailCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class BreedDetailCoordinator {
    weak var viewController: UIViewController?
}

extension BreedDetailCoordinator: BreedDetailCoordinating { }

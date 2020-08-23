import UIKit

protocol BreedsListCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func showDetailsWithBreed(_ breed: Breed)
}

final class BreedsListCoordinator {
    weak var viewController: UIViewController?
}

extension BreedsListCoordinator: BreedsListCoordinating {
    func showDetailsWithBreed(_ breed: Breed) {
        let detailsController = BreedDetailFactory().make(breed: breed)
        viewController?.showDetailViewController(detailsController, sender: self)
    }
}

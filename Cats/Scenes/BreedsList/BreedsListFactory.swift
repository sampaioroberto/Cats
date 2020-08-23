import UIKit

final class BreedsListFactory {
    func make() -> UIViewController {
        let coordinator = BreedsListCoordinator()
        let presenter = BreedsListPresenter(coordinator: coordinator)
        let interactor = BreedsListInteractor(presenter: presenter)
        return BreedsListViewController(interactor: interactor)
    }
}

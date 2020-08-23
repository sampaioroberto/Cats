import UIKit

final class BreedsListFactory {
    func make() -> UIViewController {
        let coordinator = BreedsListCoordinator()
        let presenter = BreedsListPresenter(coordinator: coordinator)
        let service = BreedsListService()
        let interactor = BreedsListInteractor(presenter: presenter, service: service)
        let viewController = BreedsListViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}

import UIKit

final class BreedDetailFactory {
    func make(breed: Breed) -> UIViewController {
        let coordinator = BreedDetailCoordinator()
        let presenter = BreedDetailPresenter(coordinator: coordinator)
        let service = BreedDetailService()
        let interactor = BreedDetailInteractor(presenter: presenter, service: service, breed: breed)
        let viewController = BreedDetailViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}

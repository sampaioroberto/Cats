import UIKit

final class BreedDetailFactory {
    func make(breed: Breed) -> UIViewController {
        let presenter = BreedDetailPresenter()
        let service = BreedDetailService()
        let interactor = BreedDetailInteractor(presenter: presenter, service: service, breed: breed)
        let viewController = BreedDetailViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}

import UIKit
@testable import Cats

enum ServiceType {
    case success
    case failure
}

private final class FakeBreedsListService: BreedsListServicing {
    private let type: ServiceType

    init(type: ServiceType) {
        self.type = type
    }

    func requestBreeds(completion: @escaping (Result<[Breed], WebServiceError>) -> Void) {
        switch type {
        case .success:
            completion(.success([
                Breed(
                    name: "Breed", adaptability: 1, dogFriendly: 1, intelligence: 1,
                    energyLevel: 1, description: "Description", id: "id"
                )
            ]))
        case .failure:
            completion(.failure(.unexpected))
        }
    }
}

final class FakeBreedsListFactory {
    func make(serviceType: ServiceType) -> UIViewController {
        let coordinator = BreedsListCoordinator()
        let presenter = BreedsListPresenter(coordinator: coordinator)
        let service = FakeBreedsListService(type: serviceType)
        let interactor = BreedsListInteractor(presenter: presenter, service: service)
        let viewController = BreedsListViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}

import UIKit
@testable import Cats

private final class FakeBreedDetailService: BreedDetailServicing {
    private let type: ServiceType

    init(type: ServiceType) {
        self.type = type
    }

    func requestImagesWithBreedId(
        _ breedId: String,
        completion: @escaping (Result<[ImageResponse], WebServiceError>) -> Void
    ) {
        switch type {
        case .success:
            completion(.success([ImageResponse(url: "www.url.com")]))
        case .failure:
            completion(.failure(.unexpected))
        }
    }
}

final class FakeBreedDetailFactory {
    func make(serviceType: ServiceType) -> UIViewController {
        let breed = Breed(
            name: "Breed",
            adaptability: 1,
            dogFriendly: 2,
            intelligence: 3,
            energyLevel: 4,
            description: "Description", id: "id"
        )
        let presenter = BreedDetailPresenter()
        let service = FakeBreedDetailService(type: serviceType)
        let interactor = BreedDetailInteractor(presenter: presenter, service: service, breed: breed)
        let viewController = BreedDetailViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}

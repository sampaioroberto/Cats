import Foundation

protocol BreedsListInteracting: AnyObject {
    func requestBreeds()
}

final class BreedsListInteractor {
    private let presenter: BreedsListPresenting
    private let service: BreedsListServicing
    private var breeds = [Breed]()
    
    init(presenter: BreedsListPresenting, service: BreedsListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension BreedsListInteractor: BreedsListInteracting {
    func requestBreeds() {
        presenter.presentLoading()
        service.requestBreeds { [weak self] result in
            self?.presenter.hideLoading()
            switch result {
            case let .success(breeds):
                self?.breeds = breeds
                self?.presenter.presentBreedsNames(
                    breeds.map { $0.name }
                )
            case let .failure(error):
                print(error)
            }
        }
    }
}

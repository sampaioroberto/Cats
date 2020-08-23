import Foundation

protocol BreedDetailInteracting: AnyObject {
    func showDetails()
    func requestCatImage()
}

final class BreedDetailInteractor {
    private let presenter: BreedDetailPresenting
    private let service: BreedDetailServicing
    private let breed: Breed

    init(presenter: BreedDetailPresenting, service: BreedDetailServicing, breed: Breed) {
        self.presenter = presenter
        self.service = service
        self.breed = breed
    }
}

extension BreedDetailInteractor: BreedDetailInteracting {
    func showDetails() {
        presenter.presentDetailsWithBreed(breed)
        requestCatImage()
    }

    func requestCatImage() {
        service.requestImagesWithBreedId(breed.id) { [weak self] response in
            switch response {
            case let .success(images):
                guard let image = images.first, let url = URL(string: image.url) else {
                    self?.presenter.presentCatImageError()
                    return
                }
                self?.presenter.presentCatImageWithURL(url)
            case .failure:
                self?.presenter.presentCatImageError()
            }
        }
    }
}

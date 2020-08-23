protocol BreedDetailInteracting: AnyObject {
    func showDetails()
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
    }
}

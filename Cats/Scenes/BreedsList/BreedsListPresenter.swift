import Foundation

protocol BreedsListPresenting: AnyObject {
    func presentBreeds(_ breeds: [Breed])
    func presentLoading()
    func hideLoading()
    func presentErrorWithMessage(_ message: String)
    func presentDetailsWithBreed(_ breed: Breed)
}

final class BreedsListPresenter {
    private let coordinator: BreedsListCoordinating
    weak var viewController: BreedsListDisplay?
    
    init(coordinator: BreedsListCoordinating) {
        self.coordinator = coordinator
    }
}

extension BreedsListPresenter: BreedsListPresenting {
    func presentBreeds(_ breeds: [Breed]) {
        viewController?.displayBreedsNames(breeds.map { $0.name })
    }

    func presentLoading() {
        viewController?.displayLoading()
    }

    func hideLoading() {
        viewController?.hideLoading()
    }

    func presentErrorWithMessage(_ message: String) {
        viewController?.displayErrorWithMessage(message)
    }

    func presentDetailsWithBreed(_ breed: Breed) {
        coordinator.showDetailsWithBreed(breed)
    }
}

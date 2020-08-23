import Foundation

protocol BreedsListPresenting: AnyObject {
    func presentBreedsNames(_ names: [String])
    func presentLoading()
    func hideLoading()
}

final class BreedsListPresenter {
    private let coordinator: BreedsListCoordinating
    weak var viewController: BreedsListDisplay?
    
    init(coordinator: BreedsListCoordinating) {
        self.coordinator = coordinator
    }
}

extension BreedsListPresenter: BreedsListPresenting {
    func presentBreedsNames(_ names: [String]) {
        viewController?.displayBreedsNames(names)
    }

    func presentLoading() {
        viewController?.displayLoading()
    }

    func hideLoading() {
        viewController?.hideLoading()
    }
}

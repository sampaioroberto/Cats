import Foundation

protocol BreedsListPresenting: AnyObject {
    func presentBreedsNames(_ names: [String])
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
}

import Foundation

protocol BreedsListPresenting: AnyObject { }

final class BreedsListPresenter {
    private let coordinator: BreedsListCoordinating
    weak var viewController: BreedsListDisplay?
    
    init(coordinator: BreedsListCoordinating) {
        self.coordinator = coordinator
    }
}

extension BreedsListPresenter: BreedsListPresenting { }

import Foundation

protocol BreedsListInteracting: AnyObject { }

final class BreedsListInteractor {
    private let presenter: BreedsListPresenting
    
    init(presenter: BreedsListPresenting) {
        self.presenter = presenter
    }
}

extension BreedsListInteractor: BreedsListInteracting { }

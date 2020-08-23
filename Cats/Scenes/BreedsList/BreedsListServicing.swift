import Foundation

protocol BreedsListServicing {
    func requestBreeds(completion: @escaping (Result<[Breed], Error>) -> Void)
}

final class BreedsListService: BreedsListServicing {
    func requestBreeds(completion: @escaping (Result<[Breed], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0) {
            completion(.success([Breed(name: "Breed1"),
            Breed(name: "Breed13278372832"),
            Breed(name: "A huge cell that needs lots of space")]))
        }
    }
}

import Foundation

protocol BreedsListServicing {
    func requestBreeds(completion: @escaping (Result<[Breed], WebServiceError>) -> Void)
}

final class BreedsListService: BreedsListServicing {
    func requestBreeds(completion: @escaping (Result<[Breed], WebServiceError>) -> Void) {
        BaseWebService().request(path: .breeds) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}

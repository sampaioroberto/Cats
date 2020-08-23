import Foundation

protocol BreedDetailServicing {
    func requestImagesWithBreedId(
        _ breedId: String,
        completion: @escaping (Result<[ImageResponse], WebServiceError>) -> Void
    )
}

final class BreedDetailService: BreedDetailServicing {
    func requestImagesWithBreedId(
        _ breedId: String,
        completion: @escaping (Result<[ImageResponse], WebServiceError>) -> Void
    ) {
        BaseWebService().request(path: .images, parameters: ["breed_id": breedId]) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}

import Foundation

protocol WebService {
    func request<T: Decodable>(
      path: Path,
      method: HTTPMethod,
      parameters: [String: Any],
      completion: @escaping (Result<T, WebServiceError>) -> Void
    )
}

extension WebService {
    func request<T: Decodable>(
      path: Path,
      method: HTTPMethod = .get,
      parameters: [String: Any] = [:],
      completion: @escaping (Result<T, WebServiceError>) -> Void
    ) {
        request(path: path, method: method, parameters: parameters, completion: completion)
    }
}

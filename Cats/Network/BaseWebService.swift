import Foundation

struct BaseWebService: WebService {
    private let timeout: TimeInterval

    init(timeout: TimeInterval = 20.0) {
        self.timeout = timeout
    }

    func request<T: Decodable>(
        path: Path,
        method: HTTPMethod = .get,
        parameters: [String: Any],
        completion: @escaping (Result<T, WebServiceError>) -> Void
    ) {
        let api = API(path: path).value

        guard let url = URL(string: api) else {
            completion(.failure(.malformedURL))
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue(API.key, forHTTPHeaderField: API.headerKey)

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout

        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                switch error.code {
                case NSURLErrorTimedOut:
                    completion(.failure(.timedOut))
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.notConnectedToInternet))
                default:
                    completion(.failure(.unexpected))
                }
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unexpected))
                return
            }

            guard 200...299 ~= response.statusCode else {
                completion(.failure(.unexpected))
                return
            }

            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.unparseable))
                }
            }
        }.resume()
    }
}

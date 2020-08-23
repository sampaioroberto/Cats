import Foundation

import Keys

enum Path: String {
    case breeds
    case images = "images/search"
}

struct API {
    private let host = "https://api.thecatapi.com"
    private let version = "v1"

    static let headerKey = "x-api-key"
    static let key = CatsKeys().apiCatsSecret

    private let path: Path

    init(path: Path) {
        self.path = path
    }

    var value: String {
        "\(host)/\(version)/\(path.rawValue)"
    }
}

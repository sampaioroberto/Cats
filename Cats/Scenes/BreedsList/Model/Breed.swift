import Foundation

struct Breed: Decodable, Equatable {
    let name: String
    let adaptability: Int
    let dogFriendly: Int
    let intelligence: Int
    let energyLevel: Int
    let description: String
    let id: String
}

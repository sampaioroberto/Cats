import Foundation

protocol BreedDetailPresenting: AnyObject {
    func presentDetailsWithBreed(_ breed: Breed)
}

final class BreedDetailPresenter {
    private let coordinator: BreedDetailCoordinating
    weak var viewController: BreedDetailDisplay?

    init(coordinator: BreedDetailCoordinating) {
        self.coordinator = coordinator
    }
}

extension BreedDetailPresenter: BreedDetailPresenting {
    func presentDetailsWithBreed(_ breed: Breed) {
        let adaptability = "Adaptability: \(String(repeating: "🌊", count: breed.adaptability))"
        let dogFriendly = "Dog Friendly: \(String(repeating: "🐶", count: breed.dogFriendly))"
        let intelligence = "Intelligence: \(String(repeating: "🧠", count: breed.intelligence))"
        let energyLevel = "Energy Level: \(String(repeating: "⚡️", count: breed.energyLevel))"

        viewController?.displayDetailsWith(
            name: breed.name,
            description: breed.description,
            attributesItems: [adaptability, dogFriendly, intelligence, energyLevel]
        )
    }
}

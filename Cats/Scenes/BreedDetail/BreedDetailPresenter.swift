import Foundation

protocol BreedDetailPresenting: AnyObject {
    func presentDetailsWithBreed(_ breed: Breed)
    func presentCatImageWithURL(_ url: URL)
    func presentCatImageError()
}

final class BreedDetailPresenter {
    weak var viewController: BreedDetailDisplay?
}

extension BreedDetailPresenter: BreedDetailPresenting {
    func presentDetailsWithBreed(_ breed: Breed) {
        let adaptability = Strings.adaptability(String(repeating: "🌊", count: breed.adaptability))
        let dogFriendly = Strings.dogFriendly(String(repeating: "🐶", count: breed.dogFriendly))
        let intelligence = Strings.intelligence(String(repeating: "🧠", count: breed.intelligence))
        let energyLevel = Strings.energyLevel(String(repeating: "⚡️", count: breed.energyLevel))

        viewController?.displayDetailsWith(
            name: breed.name,
            description: breed.description,
            attributesItems: [adaptability, dogFriendly, intelligence, energyLevel]
        )
    }

    func presentCatImageWithURL(_ url: URL) {
        viewController?.displayCatImageWithURL(url)
    }

    func presentCatImageError() {
        viewController?.displayCatImageError()
    }
}

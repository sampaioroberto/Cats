@testable import Cats
import XCTest

private final class BreedDetailSpyViewController: BreedDetailDisplay {
    private(set) var didDisplayDetailsWithCallCount = 0
    private(set) var name: String?
    private(set) var description: String?
    private(set) var attributesItems: [String]?
    private(set) var didDisplayCatImageWithURLCallCount = 0
    private(set) var url: URL?
    private(set) var didDisplayCatImageErrorCallCount = 0

    func displayDetailsWith(name: String, description: String, attributesItems: [String]) {
        self.didDisplayDetailsWithCallCount += 1
        self.name = name
        self.description = description
        self.attributesItems = attributesItems
    }

    func displayCatImageWithURL(_ url: URL) {
        didDisplayCatImageWithURLCallCount += 1
        self.url = url
    }

    func displayCatImageError() {
        didDisplayCatImageErrorCallCount += 1
    }
}

final class BreedDetailPresenterTests: XCTestCase {
    // MARK: - Variables
    private let viewController = BreedDetailSpyViewController()

    private lazy var presenter: BreedDetailPresenter  = {
        let pres = BreedDetailPresenter()
        pres.viewController = viewController
        return pres
    }()

    private let breed = Breed(
        name: "Breed", adaptability: 1, dogFriendly: 2, intelligence: 3,
        energyLevel: 4, description: "Description", id: "id"
    )

    // MARK: - presentDetailsWithBreed
    func testPresentBreed_ShouldCallDisplayBreedsNames() throws {
        presenter.presentDetailsWithBreed(breed)

        let fakeName = try XCTUnwrap(viewController.name)
        let fakeDescription = try XCTUnwrap(viewController.description)
        let fakeAttributesItems = try XCTUnwrap(viewController.attributesItems)

        let adaptability = "Adaptability: 🌊"
        let dogFriendly = "Dog Friendly: 🐶🐶"
        let intelligence = "Intelligence: 🧠🧠🧠"
        let energyLevel = "Energy Level: ⚡️⚡️⚡️⚡️"

        XCTAssertEqual(viewController.didDisplayDetailsWithCallCount, 1)
        XCTAssertEqual(fakeName, breed.name)
        XCTAssertEqual(fakeDescription, breed.description)
        XCTAssertEqual(fakeAttributesItems, [adaptability, dogFriendly, intelligence, energyLevel])
    }

    // MARK: - presentCatImageWithURL
    func testPresentCatImageWithURL_ShouldCallDisplayCatImageWithURL() throws {
        let url = URL(fileURLWithPath: "www.url.com")
        presenter.presentCatImageWithURL(url)

        let fakeURL = try XCTUnwrap(viewController.url)

        XCTAssertEqual(viewController.didDisplayCatImageWithURLCallCount, 1)
        XCTAssertEqual(fakeURL, url)
    }

    // MARK: - presentCatImageError
    func testPresentCatImageError_ShouldCallDisplayCatImageError() {
        presenter.presentCatImageError()

        XCTAssertEqual(viewController.didDisplayCatImageErrorCallCount, 1)
    }
}

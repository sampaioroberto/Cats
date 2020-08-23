@testable import Cats
import XCTest

private final class BreedsListSpyViewController: BreedsListDisplay {

    private(set) var didDisplayBreedsNamesCallCount = 0
    private(set) var names: [String]?
    private(set) var didDisplayLoadingCallCount = 0
    private(set) var didHideLoadingCallCount = 0
    private(set) var didDisplayErrorWithMessageCallCount = 0
    private(set) var message: String?

    func displayBreedsNames(_ names: [String]) {
        didDisplayBreedsNamesCallCount += 1
        self.names = names
    }

    func displayLoading() {
        didDisplayLoadingCallCount += 1
    }

    func hideLoading() {
        didHideLoadingCallCount += 1
    }

    func displayErrorWithMessage(_ message: String) {
        didDisplayErrorWithMessageCallCount += 1
        self.message = message
    }
}

private final class BreedsListCoordinatorSpy: BreedsListCoordinating {
    var viewController: UIViewController?

    private(set) var didHideLoadingCallCount = 0
    private(set) var breed: Breed?

    func showDetailsWithBreed(_ breed: Breed) {
        didHideLoadingCallCount += 1
        self.breed = breed
    }
}

final class BreedsListPresenterTests: XCTestCase {
    // MARK: - Variables
    private let coordinator = BreedsListCoordinatorSpy()
    private let viewController = BreedsListSpyViewController()

    private lazy var presenter: BreedsListPresenter  = {
        let pres = BreedsListPresenter(coordinator: coordinator)
        pres.viewController = viewController
        return pres
    }()

    private let breeds = [
        Breed(name: "Breed 1", adaptability: 1, dogFriendly: 2,
              intelligence: 3, energyLevel: 4, description: "Description", id: "1"),
        Breed(name: "Breed 2", adaptability: 1, dogFriendly: 2, intelligence: 3,
              energyLevel: 4, description: "Description", id: "2")
    ]

    // MARK: - presentBreeds
    func testPresentBreed_ShouldCallDisplayBreedsNames() throws {
        presenter.presentBreeds(breeds)

        let fakeNames = try XCTUnwrap(viewController.names)

        XCTAssertEqual(viewController.didDisplayBreedsNamesCallCount, 1)
        XCTAssertEqual(fakeNames, [breeds[0].name, breeds[1].name])
    }

    // MARK: - presentLoading
    func testPresentLoading_ShouldCallDisplayLoading() {
        presenter.presentLoading()

        XCTAssertEqual(viewController.didDisplayLoadingCallCount, 1)
    }

    // MARK: - hideLoading
    func testHideLoading_ShouldCallHideLoading() {
        presenter.hideLoading()

        XCTAssertEqual(viewController.didHideLoadingCallCount, 1)
    }

    // MARK: - presentErrorWithMessage
    func testPresentErrorWithMessage_ShouldCallDisplayErrorWithMessage() throws {
        let message = "Message"
        presenter.presentErrorWithMessage(message)

        let fakeMessage = try XCTUnwrap(viewController.message)

        XCTAssertEqual(fakeMessage, message)
    }

    // MARK: - presentDetailsWithBreed
    func testPresentDetailsWithBreed_ShouldCallShowDetailsWithBreed() throws {
        let breed = breeds[0]
        presenter.presentDetailsWithBreed(breed)

        let fakeBreed = try XCTUnwrap(coordinator.breed)

        XCTAssertEqual(fakeBreed, breed)
    }
}

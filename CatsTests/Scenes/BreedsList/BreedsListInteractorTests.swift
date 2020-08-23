@testable import Cats
import XCTest

// swiftlint:disable line_length
private final class BreedsListPresenterSpy: BreedsListPresenting {
    private(set) var didPresentBreedsCallCount = 0
    private(set) var breeds: [Breed]?
    private(set) var didPresentLoadingCallCount = 0
    private(set) var didHideLoadingCallCount = 0
    private(set) var didPresentErrorWithMessageCallCount = 0
    private(set) var message: String?
    private(set) var didPresentDetailsWithBreedCallCount = 0
    private(set) var breed: Breed?

    func presentBreeds(_ breeds: [Breed]) {
        didPresentBreedsCallCount += 1
        self.breeds = breeds
    }

    func presentLoading() {
        didPresentLoadingCallCount += 1
    }

    func hideLoading() {
        didHideLoadingCallCount += 1
    }

    func presentErrorWithMessage(_ message: String) {
        didPresentErrorWithMessageCallCount += 1
        self.message = message
    }

    func presentDetailsWithBreed(_ breed: Breed) {
        didPresentDetailsWithBreedCallCount += 1
        self.breed = breed
    }

    var viewController: BreedsListDisplay?
}

private final class BreedsListServiceMock: BreedsListServicing {
    var result: Result<[Breed], WebServiceError>?

    func requestBreeds(completion: @escaping (Result<[Breed], WebServiceError>) -> Void) {
        guard let result = result else { return }
        completion(result)
    }
}

final class BreedsListInteractorTests: XCTestCase {
    // MARK: - Variables
    private let presenter = BreedsListPresenterSpy()
    private let service = BreedsListServiceMock()
    private let breeds = [
        Breed(name: "Breed 1", adaptability: 1, dogFriendly: 2,
              intelligence: 3, energyLevel: 4, description: "Description", id: "1"),
        Breed(name: "Breed 2", adaptability: 1, dogFriendly: 2, intelligence: 3,
              energyLevel: 4, description: "Description", id: "2")
    ]

    private lazy var interactor = BreedsListInteractor(presenter: presenter, service: service)

    // MARK: - requestBreeds
    func testRequestBreeds_ShouldCallPresentLoading() {
        interactor.requestBreeds()
        XCTAssertEqual(presenter.didPresentLoadingCallCount, 1)
    }

    func testRequestBreeds_ShouldCallHideLoading_WhenServiceReturns() {
        service.result = .failure(.unexpected)
        interactor.requestBreeds()
        XCTAssertEqual(presenter.didPresentLoadingCallCount, 1)
    }

    func testRequestBreeds_ShouldCallPresentBreeds_WhenServiceReturnsSuccess() throws {
        service.result = .success(breeds)
        interactor.requestBreeds()

        let fakebreeds = try XCTUnwrap(presenter.breeds)

        XCTAssertEqual(presenter.didPresentLoadingCallCount, 1)
        XCTAssertEqual(breeds, fakebreeds)
    }

    func testRequestBreeds_ShouldCallPresentErrorWithServerErrorMessage_WhenServiceReturnsSuccessWithNoBreeds() throws {
        service.result = .success([])
        interactor.requestBreeds()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.didPresentErrorWithMessageCallCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Error.Breeds.serverError)
    }

    func testRequestBreeds_ShouldCallPresentErrorWithServerErrorMessage_WhenServiceReturnsUnexpected() throws {
        service.result = .failure(.unexpected)
        interactor.requestBreeds()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.didPresentErrorWithMessageCallCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Error.Breeds.serverError)
    }

    func testRequestBreeds_ShouldCallPresentErrorWithInternetConnectionErrorMessage_WhenServiceReturnsTimedOutError() throws {
        service.result = .failure(.timedOut)
        interactor.requestBreeds()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.didPresentErrorWithMessageCallCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Error.Breeds.internetConnection)
    }

    func testRequestBreeds_ShouldCallPresentErrorWithInternetConnectionErrorMessage_WhenServiceReturnsNotConnectedToInternetError() throws {
        service.result = .failure(.notConnectedToInternet)
        interactor.requestBreeds()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.didPresentErrorWithMessageCallCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Error.Breeds.internetConnection)
    }

    // MARK: - goToBreedDetailsWithItemIndex
    func testGoToBreedDetailsWithItemIndex_ShouldCallPresentDetailsWithBreed() throws {
        service.result = .success(breeds)
        interactor.requestBreeds()
        let itemIndex = 0

        interactor.goToBreedDetailsWithItemIndex(item: itemIndex)

        let fakeBreed = try XCTUnwrap(presenter.breed)

        XCTAssertEqual(presenter.didPresentDetailsWithBreedCallCount, 1)
        XCTAssertEqual(fakeBreed, breeds[itemIndex])
    }
}

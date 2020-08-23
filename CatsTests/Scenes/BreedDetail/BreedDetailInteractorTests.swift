@testable import Cats
import XCTest

// swiftlint:disable line_length
private final class BreedDetailPresenterSpy: BreedDetailPresenting {
    private(set) var didPresentDetailsWithBreedCallCount = 0
    private(set) var breed: Breed?
    private(set) var didPresentCatImageWithURLCallCount = 0
    private(set) var url: URL?
    private(set) var didPresentCatImageErrorCallCount = 0

    func presentDetailsWithBreed(_ breed: Breed) {
        didPresentDetailsWithBreedCallCount += 1
        self.breed = breed
    }
    func presentCatImageWithURL(_ url: URL) {
        didPresentCatImageWithURLCallCount += 1
        self.url = url
    }

    func presentCatImageError() {
        didPresentCatImageErrorCallCount += 1
    }

    var viewController: BreedDetailDisplay?
}

private final class BreedDetailServiceMock: BreedDetailServicing {
    var result: Result<[ImageResponse], WebServiceError>?

    func requestImagesWithBreedId(_ breedId: String, completion: @escaping (Result<[ImageResponse], WebServiceError>) -> Void) {
        guard let result = result else { return }
        completion(result)
    }
}

final class BreedDetailInteractorTests: XCTestCase {
    // MARK: - Variables
    private let presenter = BreedDetailPresenterSpy()
    private let service = BreedDetailServiceMock()
    private let breed = Breed(
        name: "Breed", adaptability: 1, dogFriendly: 2, intelligence: 3,
        energyLevel: 4, description: "Description", id: "id")

    private lazy var interactor = BreedDetailInteractor(presenter: presenter, service: service, breed: breed)

    // MARK: - showDetails
    func testShowDetail_ShouldCallPresentDetailsWithBreed() throws {
        interactor.showDetails()

        let fakeBreed = try XCTUnwrap(presenter.breed)

        XCTAssertEqual(presenter.didPresentDetailsWithBreedCallCount, 1)
        XCTAssertEqual(fakeBreed, breed)
    }

    // MARK: - requestCatImage
    func testRequestCatImage_ShouldCallPresentCatImageWithURL_WhenServiceReturnSuccess() throws {
        let url = "www.google.com.br"
        service.result = .success([ImageResponse(url: url)])
        interactor.requestCatImage()

        let fakeURL = try XCTUnwrap(presenter.url)

        XCTAssertEqual(presenter.didPresentCatImageWithURLCallCount, 1)
        XCTAssertEqual(fakeURL, URL(string: url))
    }

    func testRequestCatImage_ShouldCallPresentCatImageError_WhenServiceReturnFailure() {
        service.result = .failure(.unexpected)
        interactor.requestCatImage()

        XCTAssertEqual(presenter.didPresentCatImageErrorCallCount, 1)
    }

    func testRequestCatImage_ShouldCallPresentCatImageWithURL_WhenServiceReturnSuccessWithInvalidURL() {
        let url = ""
        service.result = .success([ImageResponse(url: url)])
        interactor.requestCatImage()

        XCTAssertEqual(presenter.didPresentCatImageErrorCallCount, 1)
    }

    func testRequestCatImage_ShouldCallPresentCatImageWithURL_WhenServiceReturnSuccessWithEmpty() {
        service.result = .success([])
        interactor.requestCatImage()

        XCTAssertEqual(presenter.didPresentCatImageErrorCallCount, 1)
    }
}

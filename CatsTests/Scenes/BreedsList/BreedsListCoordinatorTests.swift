@testable import Cats
import XCTest

final class BreedsListCoordinatorTests: XCTestCase {
    // MARK: - Variables

    private let viewControllerSpy = ViewControllerSpy()

    private lazy var coordinator: BreedsListCoordinator = {
        let coord = BreedsListCoordinator()
        coord.viewController = viewControllerSpy
        return coord
    }()

    // MARK: - showDetailsWithBreed
    func testShowDetailsWithBreed_ShouldShowBreedDetailController() throws {
        let breed = Breed(
            name: "", adaptability: 0, dogFriendly: 0,
            intelligence: 0, energyLevel: 0, description: "", id: ""
        )

        coordinator.showDetailsWithBreed(breed)

        XCTAssertTrue(viewControllerSpy.showedViewController is BreedDetailViewController)
    }
}

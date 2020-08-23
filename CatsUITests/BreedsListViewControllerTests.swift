import XCTest
import KIF
@testable import Cats

final class BreedsListViewControllerTests: KIFTestCase {
    func testRequestSuccess_ShouldShowCustomCell() {
        FakeBreedsListFactory().make(serviceType: .success).makeRoot()

        let label = tester.waitForView(withAccessibilityIdentifier: "CustomCollectionViewCell.textLabel")

        tester.expect(label, toContainText: "Breed")
    }

    func testRequestFailure_ShouldShowError() {
        FakeBreedsListFactory().make(serviceType: .failure).makeRoot()

        tester.waitForView(withAccessibilityIdentifier: "ErrorView")
    }

    func testClickOnCell_ShouldShowDetailsScreen() {
        FakeBreedsListFactory().make(serviceType: .success).makeRoot()

        tester.tapView(withAccessibilityIdentifier: "CustomCollectionViewCell")

        tester.waitForView(withAccessibilityIdentifier: "BreedDetailViewController")
    }
}

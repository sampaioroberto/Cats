import XCTest
import KIF
@testable import Cats

final class BreedDetailViewControllerTests: KIFTestCase {

    func testRequestSuccess_ShouldShowImageView() {
        FakeBreedDetailFactory().make(serviceType: .success).makeRoot()

        tester.waitForView(withAccessibilityIdentifier: "ImageViewDownloadContainerView.imageView")
    }

    func testRequestError_ShouldShowErrorView() {
        FakeBreedDetailFactory().make(serviceType: .success).makeRoot()

        tester.waitForView(withAccessibilityIdentifier: "ImageViewDownloadContainerView.errorView")
    }
}

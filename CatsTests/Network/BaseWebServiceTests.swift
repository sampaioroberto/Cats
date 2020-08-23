@testable import Cats
import Foundation
import XCTest
import OHHTTPStubs

// swiftlint:disable all
struct TestModel: Codable {
  let test: String
}

extension BaseWebService {
    static func jsonDataSuccess() -> Data? {
        let jsonSuccess: [String: String] = ["test": "ok"]
        return try? JSONSerialization.data(withJSONObject: jsonSuccess)
    }

    static func notJSONDataSuccess() -> Data {
        let string = "test"
        return Data(base64Encoded: string)!
    }
}

final class BaseWebServiceTests: XCTestCase {

    private let service = BaseWebService()

    func testRequestShouldReturnSuccess_WhenServerReturnSuccess() throws {
        let data = try XCTUnwrap(BaseWebService.jsonDataSuccess())
        stub(condition: { _ in true }) { _ in
            return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
        }

        var fakeResult: Result<TestModel, WebServiceError>?

        let expectation = XCTestExpectation(description: "testSuccess")

        service.request(path: Path.breeds) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case .success(let testModel):
            XCTAssertEqual(testModel.test, "ok")
        default:
            XCTFail("This test should have be success")
        }
    }

    func testRequestShouldReturnUnparsaebleError_WhenServerReturnSuccessWithUnparsaebleJSON() throws {
        let data = try XCTUnwrap(BaseWebService.notJSONDataSuccess())
        stub(condition: { _ in true }) { _ in

            return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
        }

        var fakeResult: Result<TestModel, WebServiceError>?

        let expectation = XCTestExpectation(description: "testErrorJSON")
        service.request(path: Path.breeds) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()

        }

        wait(for: [expectation], timeout: 2.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unparseable)
        default:
            XCTFail("This test should return an unparsaeble error")
        }
    }

    func testRequestShouldReturnUnexpectedError_WhenServerReturn500() throws {
        let data = try XCTUnwrap(BaseWebService.jsonDataSuccess())
        stub(condition: { _ in true }) { _ in
            return HTTPStubsResponse(data: data, statusCode: 500, headers: nil)
        }

        var fakeResult: Result<TestModel, WebServiceError>?

        let expectation = XCTestExpectation(description: "testUnexpectedError")
        service.request(path: Path.breeds) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()

        }

        wait(for: [expectation], timeout: 2.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unexpected)
        default:
            XCTFail("This test should return an unexpected error")
        }
    }
}

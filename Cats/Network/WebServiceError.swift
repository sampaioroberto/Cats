import Foundation

enum WebServiceError: Error {
  case notConnectedToInternet
  case timedOut
  case unexpected
  case malformedURL
  case unparseable
  case empty
}

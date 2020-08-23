import KIF

extension XCTestCase {

  var tester: KIFUITestActor { return tester() }
  var system: KIFSystemTestActor { return system() }

  private func tester(_ file: String = #file, _ line: Int = #line) -> KIFUITestActor {
    return KIFUITestActor(inFile: file, atLine: line, delegate: self)
  }

  private func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
    return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
  }
}

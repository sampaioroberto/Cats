// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  /// Breeds
  internal static let breeds = Strings.tr("Localizable", "breeds")

  internal enum Error {
    /// Try again
    internal static let tryAgain = Strings.tr("Localizable", "Error.tryAgain")
    internal enum Breeds {
      /// Meeeow, there's some internet issues. Please check if you have internet connection and try again
      internal static let internetConnection = Strings.tr("Localizable", "Error.Breeds.internetConnection")
      /// Meeeow, someone stepped on our cat's tail and the cat's server stopped to work. Please try again
      internal static let serverError = Strings.tr("Localizable", "Error.Breeds.serverError")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type

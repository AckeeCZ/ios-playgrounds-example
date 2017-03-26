// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
// swiftlint:disable nesting
// swiftlint:disable variable_name
// swiftlint:disable valid_docs
// swiftlint:disable type_name

enum L10n {
  static var language: String?

  enum LanguageDetail {
    /// Play sentence
    static let play = L10n.tr("language_detail.play")
  }

  enum Welcome {
    /// Did your unicorn get stolen? Act quickly and allow the application to access your location
    static let description = L10n.tr("welcome.description")
    /// I will do anything, just get it back!
    static let enable = L10n.tr("welcome.enable")
    /// Nope, I'll risk it
    static let skip = L10n.tr("welcome.skip")
    /// Who stole my unicorn?
    static let title = L10n.tr("welcome.title")
  }
}

extension L10n {
  fileprivate static func tr(_ key: String, _ args: CVarArg...) -> String {
  	let bundle = Bundle(for: BundleToken.self)
    if let language = language, let path = bundle.path(forResource: language, ofType: "lproj"), let localizedBundle = Bundle(path: path) {
        print(key)
        return localizedBundle.localizedString(forKey: key, value: nil, table: "Localizable")
    }
    let format = NSLocalizedString(key, bundle: bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

// swiftlint:enable type_body_length
// swiftlint:enable nesting
// swiftlint:enable variable_name
// swiftlint:enable valid_docs

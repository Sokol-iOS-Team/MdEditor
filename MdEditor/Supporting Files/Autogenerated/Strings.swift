// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum Main {
    /// Main
    internal static let title = L10n.tr("Localizable", "Main.title")
  }

  internal enum MenuItem {
    /// About
    internal static let about = L10n.tr("Localizable", "MenuItem.about")
    /// New
    internal static let new = L10n.tr("Localizable", "MenuItem.new")
    /// Open
    internal static let `open` = L10n.tr("Localizable", "MenuItem.open")
    /// Test
    internal static let test = L10n.tr("Localizable", "MenuItem.test")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum Authorization {
    /// Enter
    internal static let authorization = L10n.tr("Localizable", "Authorization.authorization")
    /// Authorization
    internal static let title = L10n.tr("Localizable", "Authorization.title")
    /// Wrong login or password
    internal static let wrongCredentials = L10n.tr("Localizable", "Authorization.wrongCredentials")
  }

  internal enum Extensions {

    internal enum UIViewController {

      internal enum CustomAlert {
        /// Cancel
        internal static let cancelButton = L10n.tr("Localizable", "Extensions.UIViewController.CustomAlert.CancelButton")
      }

      internal enum SimpleAlert {
        /// OK
        internal static let buttonTitle = L10n.tr("Localizable", "Extensions.UIViewController.SimpleAlert.ButtonTitle")
      }
    }
  }

  internal enum Main {
    /// Main
    internal static let title = L10n.tr("Localizable", "Main.title")

    internal enum FileCreatedAlert {
      /// You can find the file in the Documents folder
      internal static let message = L10n.tr("Localizable", "Main.FileCreatedAlert.message")
      /// File successfully created
      internal static let title = L10n.tr("Localizable", "Main.FileCreatedAlert.title")
    }

    internal enum Interactor {

      internal enum ErrorResponse {

        internal enum FileExist {
          /// File with the same name already exists.
          internal static let message = L10n.tr("Localizable", "Main.Interactor.ErrorResponse.FileExist.message")
          /// Error
          internal static let title = L10n.tr("Localizable", "Main.Interactor.ErrorResponse.FileExist.title")
        }
      }
    }

    internal enum NewFileAlert {
      /// Create
      internal static let okActionTitle = L10n.tr("Localizable", "Main.NewFileAlert.okActionTitle")
      /// File
      internal static let placeholder = L10n.tr("Localizable", "Main.NewFileAlert.placeholder")
      /// Enter the file name
      internal static let title = L10n.tr("Localizable", "Main.NewFileAlert.title")
    }
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
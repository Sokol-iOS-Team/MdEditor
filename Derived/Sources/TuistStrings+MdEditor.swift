// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

public enum MdEditorStrings {
  public enum LaunchScreen {
  }
  public enum Localizable {

    public enum Extensions {

      public enum UIViewController {

        public enum CustomAlert {
          /// Cancel
          public static let cancelButton = MdEditorStrings.tr("Localizable", "Extensions.UIViewController.CustomAlert.CancelButton")
        }

        public enum SimpleAlert {
          /// OK
          public static let buttonTitle = MdEditorStrings.tr("Localizable", "Extensions.UIViewController.SimpleAlert.ButtonTitle")
        }
      }
    }

    public enum Main {
      /// Main
      public static let title = MdEditorStrings.tr("Localizable", "Main.title")

      public enum FileCreatedAlert {
        /// You can find the file in the Documents folder
        public static let message = MdEditorStrings.tr("Localizable", "Main.FileCreatedAlert.message")
        /// File successfully created
        public static let title = MdEditorStrings.tr("Localizable", "Main.FileCreatedAlert.title")
      }

      public enum Interactor {

        public enum ErrorResponse {

          public enum FileExist {
            /// File with the same name already exists.
            public static let message = MdEditorStrings.tr("Localizable", "Main.Interactor.ErrorResponse.FileExist.message")
            /// Error
            public static let title = MdEditorStrings.tr("Localizable", "Main.Interactor.ErrorResponse.FileExist.title")
          }
        }
      }

      public enum NewFileAlert {
        /// Create
        public static let okActionTitle = MdEditorStrings.tr("Localizable", "Main.NewFileAlert.okActionTitle")
        /// File
        public static let placeholder = MdEditorStrings.tr("Localizable", "Main.NewFileAlert.placeholder")
        /// Enter the file name
        public static let title = MdEditorStrings.tr("Localizable", "Main.NewFileAlert.title")
      }
    }

    public enum MenuItem {
      /// About
      public static let about = MdEditorStrings.tr("Localizable", "MenuItem.about")
      /// New
      public static let new = MdEditorStrings.tr("Localizable", "MenuItem.new")
      /// Open
      public static let `open` = MdEditorStrings.tr("Localizable", "MenuItem.open")
      /// Test
      public static let test = MdEditorStrings.tr("Localizable", "MenuItem.test")
    }
  }
}

extension MdEditorStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all
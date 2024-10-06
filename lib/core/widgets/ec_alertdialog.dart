import "package:e_commerce/config/path_export.dart";


/// A utility class for displaying custom alert dialogs in the application.
///
/// The `ECAlertDialog` class provides a static method to show an alert dialog
/// with a title, message, and custom action buttons. This dialog is non-dismissible
/// by tapping outside, making it useful for critical alerts or confirmations.
///
/// The `showAlertDialog` method can be used throughout the app to display custom
/// messages and action buttons.
class ECAlertDialog {

  /// Displays a custom alert dialog with the specified [title], [message], and [actions].
  ///
  /// - [context]: The `BuildContext` in which the dialog should be displayed.
  /// - [title]: A string to be shown as the dialog title.
  /// - [message]: The main content of the dialog, typically used for the message.
  /// - [actions]: A list of `Widget` actions (usually buttons) to display at the bottom of the dialog.
  ///
  /// ## Parameters:
  /// - **context**: Required. The `BuildContext` to use for locating the dialog's position.
  /// - **title**: Required. A `String` that defines the dialog's title.
  /// - **message**: Required. A `String` that defines the dialog's content or message.
  /// - **actions**: Optional. A list of `Widget` objects to represent the dialog's action buttons.
  ///
  /// ## Returns:
  /// A `Future<void>` that completes when the dialog is dismissed.
  ///

  static Future<void> showAlertDialog(
      BuildContext context,
      String title,
      String message,
      List<Widget>? actions,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title), // Sets the dialog title
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message), // Sets the main message of the dialog
              ],
            ),
          ),
          actions: actions, // Displays the provided actions, if any
        );
      },
    );
  }
}

import "package:e_commerce/config/path_export.dart";


/// A custom button widget with optional width, color, and text styling.
///
/// The `ECButton` widget is designed to offer a configurable button that triggers a provided
/// function when pressed. It supports custom button titles, colors, widths, and font styles.
///
/// - [buttonTitle] is a required string that represents the text displayed on the button.
/// - [onClick] is a required function that will be called when the button is pressed.
/// - [width] is an optional parameter to define the button's width. If not provided, it defaults to a quarter of the screen width.
/// - [buttonColor] is an optional color for the button's background. Defaults to a brown shade if not provided.
/// - [fontStyle] is an optional text style for the button title. If not provided, it defaults to a brown-shaded style.
class ECButton extends StatelessWidget {
  final String buttonTitle;
  final Function onClick;
  final double? width;
  final Color? buttonColor;
  final TextStyle? fontStyle;

  /// Creates an `ECButton` widget.
  ///
  /// The [buttonTitle] and [onClick] are required to define the button's label and functionality.
  /// The [width], [buttonColor], and [fontStyle] are optional for further customization.
  const ECButton({
    super.key,
    required this.buttonTitle,
    required this.onClick,
    this.width,
    this.buttonColor,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: buttonColor, // Sets the button's background color
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)), // Adds rounded corners
          side: BorderSide(
            color: buttonColor ?? Colors.brown.shade800, // Border color defaults to brown if not provided
            width: 0.5, // Border width
          ),
        ),
      ),
      onPressed: () {
        onClick(); // Triggers the function when the button is pressed
      },
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width / 4, // Button width with default fallback
        height: 50, // Fixed height of the button
        child: Center(
          child: Text(
            buttonTitle, // Displays the button's title
            style: fontStyle ?? TextStyle(color: Colors.brown.shade800), // Text style with default fallback
          ),
        ),
      ),
    );
  }
}

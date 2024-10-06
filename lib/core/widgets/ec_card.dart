import "package:e_commerce/config/path_export.dart";

/// A custom card widget that wraps a child widget and provides optional styling.
///
/// The `ECCard` widget offers a container with an optional box decoration
/// and customizable margin and color for the card.
///
/// - [child] is a required widget that will be placed inside the card.
/// - [isBoxDecoration] controls whether the card should have a flat or elevated appearance.
/// - [cardMarginSize] optionally sets the margin around the card.
/// - [cardColor] optionally sets the background color of the card.
class ECCard extends StatelessWidget {
  final Widget child;
  final bool isBoxDecoration;
  final EdgeInsetsGeometry? cardMarginSize;
  final Colors? cardColor;

  /// Creates an `ECCard` widget.
  ///
  /// The [child] is required and represents the content inside the card.
  /// The [isBoxDecoration] controls if the card has box decoration (elevation).
  /// The [cardMarginSize] and [cardColor] are optional.
  const ECCard({
    super.key,
    required this.child,
    this.cardMarginSize,
    required this.isBoxDecoration,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white, // Background color of the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(
            color: Colors.grey, // Border color of the card
            width: 0.5, // Border width of the card
          ),
        ),
      ),
      child: Card(
        color: Colors.white,
        elevation: isBoxDecoration ? 0 : 1, // Controls elevation based on [isBoxDecoration]
        margin: cardMarginSize ?? const EdgeInsets.all(4.0), // Sets the margin around the card
        child: child, // Displays the content inside the card
      ),
    );
  }
}

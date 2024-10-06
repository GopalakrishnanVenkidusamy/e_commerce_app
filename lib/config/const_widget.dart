import 'package:flutter/material.dart';

/// A utility class that provides commonly used constant widgets and padding values
/// to avoid repetition and maintain consistency throughout the application.
///
/// This class includes predefined SizedBox widgets for spacing, EdgeInsets for padding,
/// and a Divider for UI layouts.
class ConstWidget {

  // ------------------- Sized Box Constants ------------------- //

  /// A [SizedBox] with a height of 5 pixels.
  static const kSizeBoxHeight5 = SizedBox(height: 5);

  /// A [SizedBox] with a height of 10 pixels.
  static const kSizeBoxHeight10 = SizedBox(height: 10);

  /// A [SizedBox] with a height of 15 pixels.
  static const kSizeBoxHeight15 = SizedBox(height: 15);

  /// A [SizedBox] with a height of 20 pixels.
  static const kSizeBoxHeight20 = SizedBox(height: 20);

  /// A [SizedBox] with a height of 25 pixels.
  static const kSizeBoxHeight25 = SizedBox(height: 25);

  /// A [SizedBox] with a height of 30 pixels.
  static const kSizeBoxHeight30 = SizedBox(height: 30);

  /// A [SizedBox] with a width of 5 pixels.
  static const kSizeBoxWidth5 = SizedBox(width: 5);

  /// A [SizedBox] with a width of 10 pixels.
  static const kSizeBoxWidth10 = SizedBox(width: 10);

  /// A [SizedBox] with a width of 15 pixels.
  static const kSizeBoxWidth15 = SizedBox(width: 15);

  /// A [SizedBox] with a width of 20 pixels.
  static const kSizeBoxWidth20 = SizedBox(width: 20);

  /// A [SizedBox] with a width of 25 pixels.
  static const kSizeBoxWidth25 = SizedBox(width: 25);

  /// A [SizedBox] with a width of 30 pixels.
  static const kSizeBoxWidth30 = SizedBox(width: 30);

  // ------------------- Padding Constants ------------------- //

  /// An [EdgeInsets] padding of 6 pixels applied on all sides.
  static const paddingAll6 = EdgeInsets.all(6);

  /// An [EdgeInsets] padding of 8 pixels applied on all sides.
  static const paddingAll8 = EdgeInsets.all(8);

  /// An [EdgeInsets] padding of 10 pixels applied on all sides.
  static const paddingAll10 = EdgeInsets.all(10);

  /// An [EdgeInsets] padding of 15 pixels applied on all sides.
  static const paddingAll15 = EdgeInsets.all(15);

  /// An [EdgeInsets] padding of 20 pixels applied on all sides.
  static const paddingAll20 = EdgeInsets.all(20);

  /// An [EdgeInsets] padding of 25 pixels applied on all sides.
  static const paddingAll25 = EdgeInsets.all(25);

  /// An [EdgeInsets] padding of 30 pixels applied on all sides.
  static const paddingAll30 = EdgeInsets.all(30);

  /// An [EdgeInsets] padding of 15 pixels applied to the right side only.
  static const paddingRight15 = EdgeInsets.only(right: 15);

  /// An [EdgeInsets] padding of 10 pixels applied to the top side only.
  static const paddingTop10 = EdgeInsets.only(top: 10);

  // ------------------- Divider Constants ------------------- //

  /// A [Divider] with a height of 0.2 and a color of brown shade 800.
  static const Divider dividerHeight5 = Divider(
    height: 0.2,
    color: Colors.brown, // Adjusted to use a specific shade for clarity
  );
}

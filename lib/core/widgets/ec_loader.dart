import "package:e_commerce/config/path_export.dart";

/// A widget that displays a centered circular progress indicator.
///
/// Typically used to show loading or processing state in the application.
class ECLoader extends StatelessWidget {
  const ECLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a centered CircularProgressIndicator to indicate a loading state.
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}


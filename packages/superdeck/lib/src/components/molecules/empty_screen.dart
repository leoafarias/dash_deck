import 'package:flutter/widgets.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No slides found'),
    );
  }
}

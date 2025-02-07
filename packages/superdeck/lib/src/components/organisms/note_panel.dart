import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class NotePanel extends StatelessWidget {
  const NotePanel({
    super.key,
    required this.notes,
  });

  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $box.margin(10),
      $box.color(const Color.fromARGB(255, 35, 35, 35)),
      $box.minHeight(100),
      $box.padding(10),
      $box.borderRadius(10),
      $flex.crossAxisAlignment.stretch(),
    );
    return VBox(
      style: style,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: notes.map(Text.new).toList(),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class CommentsPanel extends StatelessWidget {
  const CommentsPanel({
    super.key,
    required this.comments,
  });

  final List<String> comments;

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $box.margin(10, 10, 0, 10),
      $box.color(const Color.fromARGB(255, 35, 35, 35)),
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
            children: comments.map(Text.new).toList(),
          ),
        ),
      ],
    );
  }
}

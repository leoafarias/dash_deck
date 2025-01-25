import 'package:flutter/material.dart';

class NotePanel extends StatelessWidget {
  const NotePanel({
    super.key,
    required this.notes,
  });

  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notes
                    .map(
                      (note) => Text(note),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

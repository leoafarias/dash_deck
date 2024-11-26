import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/presentation/presentation_hooks.dart';

class NotePanel extends HookWidget {
  const NotePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final slide = useDeck.activeSlide();

    final notes =
        slide.notes.isEmpty ? [Note(content: 'No notes')] : slide.notes;

    if (slide.notes.isEmpty) return const SizedBox.shrink();

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
                      (note) => Text(note.content),
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

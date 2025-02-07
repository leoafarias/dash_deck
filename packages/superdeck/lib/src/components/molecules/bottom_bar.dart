import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../modules/navigation/navigation_controller.dart';

class DeckBottomBar extends StatelessWidget {
  const DeckBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = NavigationController.of(context);

    final currentPage = navigation.currentSlide.slideIndex + 1;
    final totalPages = navigation.totalSlides;

    return _BottomBarContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // view notes
          IconButton(
            onPressed: navigation.toggleNotes,
            icon: navigation.isNotesOpen
                ? const Icon(Icons.comment)
                : const Icon(Icons.comments_disabled),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: navigation.previousSlide,
          ),

          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: navigation.nextSlide,
          ),
          const Spacer(),
          Text(
            '${navigation.currentSlide.slideIndex + 1} of $totalPages',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: navigation.closeMenu,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class _BottomBarContainer extends StatelessWidget {
  const _BottomBarContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $box.height(60),
      $box.borderRadius(16),
      $box.color(const Color.fromARGB(255, 17, 17, 17)),
      $box.padding(10, 20),
      $box.margin(12),
    );

    return Box(
      style: style,
      child: child,
    );
  }
}

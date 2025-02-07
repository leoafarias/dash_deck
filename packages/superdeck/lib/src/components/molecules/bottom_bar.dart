import 'package:flutter/material.dart';

import '../../modules/navigation/navigation_controller.dart';

class DeckBottomBar extends StatelessWidget {
  const DeckBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = NavigationController.of(context);

    return SizedBox(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      child: ClipRect(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(171, 21, 21, 21),
            border: Border(
              top: BorderSide(
                color: Colors.white10,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // view notes
              IconButton(
                onPressed: navigation.toggleNotes,
                icon: const Icon(Icons.notes),
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
              IconButton(
                onPressed: navigation.closeMenu,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

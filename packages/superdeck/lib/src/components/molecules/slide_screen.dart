import 'package:flutter/material.dart';

import '../../modules/common/helpers/provider.dart';
import '../../modules/deck/slide_configuration.dart';
import '../atoms/slide_view.dart';

class SlideScreen extends StatelessWidget {
  const SlideScreen(
    this.slide, {
    super.key,
  });

  final SlideConfiguration slide;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 29, 29),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Provider(
          value: slide,
          child: SlideView(slide),
        ),
      ),
    );
  }
}

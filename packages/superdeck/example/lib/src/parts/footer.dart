import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

class FooterPart extends FixedSlidePartWidget {
  const FooterPart({
    super.key,
  });

  @override
  double get height => 0;

  @override
  Widget build(context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('SUPERDECK'),
        ],
      ),
    );
  }
}

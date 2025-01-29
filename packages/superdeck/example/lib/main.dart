import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

import 'src/parts/background.dart';
import 'src/parts/footer.dart';
import 'src/parts/header.dart';
import 'src/style.dart';

void main() async {
  await SuperDeckApp.initialize();
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        title: 'Superdeck',
        debugShowCheckedModeBanner: false,
        home: SuperDeckApp(
          options: DeckOptions(
            baseStyle: BaseStyle(),
            debug: true,
            styles: {
              'announcement': AnnouncementStyle(),
              'quote': QuoteStyle(),
            },
            parts: const SlideParts(
              header: HeaderPart(),
              footer: FooterPart(),
              background: BackgroundPart(),
            ),
          ),
        ),
      );
    }),
  );
}

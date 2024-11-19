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
          baseStyle: BaseStyle(),
          styles: {
            'announcement': AnnouncementStyle(),
            'quote': QuoteStyle(),
          },
          background: const BackgroundPart(),
          header: const HeaderPart(),
          footer: const FooterPart(),

          // ignore: prefer_const_literals_to_create_immutables
        ),
      );
    }),
  );
}

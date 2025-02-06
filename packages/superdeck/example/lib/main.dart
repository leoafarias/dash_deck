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
            widgets: {
              'twitter': (args) {
                return TwitterWidget(
                  username: args['username'] as String,
                  tweetId: args['tweetId'] as String,
                );
              },
            },
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

class TwitterWidget extends StatelessWidget {
  final String username;
  final String tweetId;

  const TwitterWidget(
      {super.key, required this.username, required this.tweetId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text('Twitter: $username'),
    );
  }
}

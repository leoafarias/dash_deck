import 'dart:async';
import 'dart:developer';

import 'package:puppeteer/puppeteer.dart';
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';

Future<String> _generateMermaidGraph(
  Browser browser,
  String graphDefinition,
) async {
  logger
    ..detail('')
    ..detail('Generating mermaid graph...')
    ..detail(graphDefinition)
    ..detail('');

  final page = await browser.newPage();

  await page.setContent('''
    <html>

    
      <body>
        <pre class="mermaid">
          $graphDefinition
        </pre>
        <script type="module">
          import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';

           const themeVariables = {
            darkMode: true, // Dark mode is enabled
            background: '#000000', // Background color
            fontFamily: 'Arial, sans-serif', // Font family
            fontSize: '14px', // Font size
            primaryColor: '#6200FFFF', // Primary node background color
            primaryTextColor: '#FFFFFF', // Primary text color inside nodes
            primaryBorderColor: '#6200FFFF', // Primary node border color
            secondaryColor: '#ff6600', // Secondary node background color
            secondaryTextColor: '#000000', // Secondary node text color
            secondaryBorderColor: '#ff6600', // Secondary node border color
            tertiaryColor: '#ffcc00', // Tertiary node background color
            tertiaryTextColor: '#000000', // Tertiary node text color
            tertiaryBorderColor: '#ffcc00', // Tertiary node border color
            noteBkgColor: '#333333', // Note background color
            noteTextColor: '#FFFFFF', // Note text color
            noteBorderColor: '#ffcc00', // Note border color
            lineColor: '#555555', // Line color connecting the nodes
            errorBkgColor: '#00FFFBFF', // Background color for errors
            errorTextColor: '#000000', // Text color for errors
            
          };

          mermaid.initialize({
            startOnLoad: true,
            theme: 'dark',

            flowchart: {
              // defaultRenderer: "elk",
              // curve: 'linear', // Optional: 'cardinal', 'linear', 'natural', etc.
            },
            // themeVariables: themeVariables,
          });
          mermaid.run({
            querySelector: 'pre.mermaid',
          });
        </script>
      </body>
    </html>
  ''');

  await page.waitForSelector('pre.mermaid > svg',
      timeout: Duration(
        seconds: 5,
      ));
  final element = await page.$('pre.mermaid > svg');
  final svgContent = await element.evaluate('el => el.outerHTML');

  await page.close();
  return svgContent;
}

Future<String> _convertToRoughDraft(Browser browser, String svgContent) async {
  print('Converting to rough draft...');
  final page = await browser.newPage();

  await page.setContent('''
    <html>
      <body>
        <div class="svg-container">$svgContent</div>
        <div class="sketch-container"></div>
        <script src="https://unpkg.com/svg2roughjs/dist/svg2roughjs.umd.min.js"></script>
        <script>
          const svgElement = document.querySelector('.svg-container > svg');
          const svgConverter = new svg2roughjs.Svg2Roughjs('.sketch-container');
          svgConverter.svg = svgElement;
          svgConverter.sketch();
        </script>
      </body>
    </html>
  ''');

  await page.waitForSelector('.sketch-container > svg');
  final element = await page.$('.sketch-container > svg');

  final output = await element.evaluate('el => el.outerHTML');

  await page.close();

  return output;
}

Future<List<int>> _convertSvgToImage(Browser browser, String svgContent) async {
  final page = await browser.newPage();

  await page.setViewport(DeviceViewport(
    width: 1280, // Set desired width
    height: 780, // Set desired height
    deviceScaleFactor: 2, // Control the scale (1 is standard)
  ));

  await page.setContent('''
    <html>
      <body>
        <div class="svg-container">$svgContent</div>
      </body>
    </html>
  ''');

  final element = await page.$('.svg-container > svg');

  final screenshot = await element.screenshot(
    format: ScreenshotFormat.png,
    omitBackground: true,
  );

  page.onConsole.listen((msg) {
    log('PAGE LOG: ${msg.text}');
  });

  await page.close();

  return screenshot;
}

Future<List<int>> generateRoughMermaidGraph(
    Browser browser, String graphDefinition) async {
  try {
    final svgContent = await _generateMermaidGraph(browser, graphDefinition);
    // final roughDraft = await _convertToRoughDraft(browser, svgContent);

    return _convertSvgToImage(browser, svgContent);
  } on Exception catch (_) {
    throw Exception(
      'Mermaid generation timedout, maybe this is not a supported graph',
    );
  }
}

class MermaidConverterTask extends Task {
  MermaidConverterTask() : super('mermaid');
  Browser? _browser;

  Future<Browser> _getBrowser() async {
    _browser ??= await puppeteer.launch();
    return _browser!;
  }

  @override
  void dispose() {
    _browser?.close();
    _browser = null;
  }

  @override
  Future<void> run(context) async {
    final mermaidBlockRegex = RegExp(r'```mermaid.*?([\s\S]*?)```');
    final slide = context.slide;

    final matches = mermaidBlockRegex.allMatches(slide.markdown);

    if (matches.isEmpty) return;
    // final replacements = <({int start, int end, String markdown})>[];

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      final asset = MermaidImageAssetRaw.fromSyntax(mermaidSyntax);

      if (!await context.checkAssetExists(asset)) {
        final browser = await _getBrowser();

        final imageData =
            await generateRoughMermaidGraph(browser, mermaidSyntax);

        await context.writeAsset(asset, imageData);
      }

      final imageMarkdown = '![mermaid](${asset.path})';

      context.slide = context.slide.updateMarkdown(
        context.slide.markdown.replaceAll(
          match.group(0)!,
          imageMarkdown,
        ),
      );
    }
  }
}

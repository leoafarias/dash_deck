import 'dart:async';

import 'package:puppeteer/puppeteer.dart';
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

class MermaidBlockTransformer implements BlockTransformer {
  const MermaidBlockTransformer();
  @override
  String transform(String markdown) {
    final mermaidBlockRegex = RegExp(r'```mermaid.*?([\s\S]*?)```');
    final matches = mermaidBlockRegex.allMatches(markdown);

    if (matches.isEmpty) return markdown;

    final mermaidSyntax = matches.first.group(1);

    if (mermaidSyntax == null) return markdown;

    final asset = MermaidAsset.fromSyntax(mermaidSyntax);

    final mermaidBlock = MermaidBlock(syntax: mermaidSyntax, asset: asset);

    return markdown.replaceAll(matches.first.group(0)!, mermaidBlock.toJson());
  }
}

class MermaidConverterTask extends Task {
  Browser? _browser;
  MermaidConverterTask() : super('mermaid');
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
  Future<void> run(TaskContext context) async {
    final mermaidBlocks = context.blocks.whereType<MermaidBlock>();

    for (final mermaidBlock in mermaidBlocks) {
      final asset = mermaidBlock.asset;

      if (await context.dataStore.checkAssetExists(asset)) continue;

      final browser = await _getBrowser();

      final imageData =
          await _generateMermaidGraphImage(browser, mermaidBlock.syntax);

      await context.dataStore.writeAsset(asset, imageData);
    }
  }
}

/// A helper function that automates page creation, content setup, and cleanup.
Future<T> _withPage<T>(
  Browser browser,
  Future<T> Function(Page page) action,
) async {
  final page = await browser.newPage();
  try {
    return await action(page);
  } finally {
    await page.close();
  }
}

/// Extract large HTML templates to constants for better readability.
const _mermaidHtmlTemplate = '''
<html>
  <body>
    <pre class="mermaid">__GRAPH_DEFINITION__</pre>
    <script type="module">
      import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
      mermaid.initialize({
        startOnLoad: true,
        theme: 'dark',
        flowchart: {},
      });
      mermaid.run({ querySelector: 'pre.mermaid' });
    </script>
  </body>
</html>
''';

Future<String> _generateMermaidGraph(Browser browser, String graphDefinition) {
  logger.detail('Generating mermaid graph:');
  logger.detail(graphDefinition);

  final htmlContent =
      _mermaidHtmlTemplate.replaceAll('__GRAPH_DEFINITION__', graphDefinition);

  return _withPage(browser, (page) async {
    await page.setContent(htmlContent);
    await page.waitForSelector(
      'pre.mermaid > svg',
      timeout: const Duration(seconds: 5),
    );

    final element = await page.$('pre.mermaid > svg');

    return await element.evaluate('el => el.outerHTML');
  });
}

Future<List<int>> _convertSvgToImage(Browser browser, String svgContent) {
  return _withPage(browser, (page) async {
    await page.setViewport(DeviceViewport(
      width: 1280,
      height: 780,
      deviceScaleFactor: 2,
    ));

    await page.setContent('''
      <html>
        <body>
          <div class="svg-container">$svgContent</div>
        </body>
      </html>
    ''');

    final element = await page.$('.svg-container > svg');

    return await element.screenshot(
      format: ScreenshotFormat.png,
      omitBackground: true,
    );
  });
}

Future<List<int>> _generateMermaidGraphImage(
  Browser browser,
  String graphDefinition,
) async {
  try {
    final svgContent = await _generateMermaidGraph(browser, graphDefinition);

    return await _convertSvgToImage(browser, svgContent);
  } catch (e, stackTrace) {
    logger.err('Failed to generate Mermaid graph image: $e');
    Error.throwWithStackTrace(
      Exception(
        'Mermaid generation timed out or failed. Original error: $e',
      ),
      stackTrace,
    );
  }
}

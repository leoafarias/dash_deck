# src/parsers/slide_parser.dart

```dart
// lib/slide_parser.dart

import 'dart:convert';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/base_parser.dart';
import 'package:superdeck_cli/src/parsers/front_matter_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

List<String> _splitSlides(String content) {
  content = content.trim();
  final lines = LineSplitter().convert(content);
  final slides = <String>[];
  final buffer = StringBuffer();
  bool insideFrontMatter = false;

  var isCodeBlock = false;

  for (var line in lines) {
    final trimmed = line.trim();
    if (trimmed.startsWith('```')) {
      isCodeBlock = !isCodeBlock;
    }
    if (isCodeBlock) {
      buffer.writeln(line);
      continue;
    }

    if (insideFrontMatter && trimmed.isEmpty) {
      insideFrontMatter = false;
    }

    if (trimmed == '---') {
      if (!insideFrontMatter) {
        if (buffer.isNotEmpty) {
          slides.add(buffer.toString().trim());
          buffer.clear();
        }
      }
      insideFrontMatter = !insideFrontMatter;
    }
    buffer.writeln(line);
  }

  if (buffer.isNotEmpty) {
    slides.add(buffer.toString());
  }

  return slides;
}

class SlideParser extends Parser<Slide> {
  @override
  Slide parse(String input) {
    final extracted = FrontMatterParser().parse(input);

    final regexComments = RegExp(r'<!--(.*?)-->', dotAll: true);

    final notes = <Note>[];
    final comments = regexComments.allMatches(extracted.contents);

    for (final comment in comments) {
      final note = {
        'content': comment.group(1)?.trim(),
      };
      Note.schema.validateOrThrow(note);
      notes.add(Note.fromMap(note));
    }

    // Whole content of the match
    return Slide.parse({
      'options': extracted.frontMatter,
      'markdown': extracted.contents,
      'key': extracted.key
    }).copyWith(notes: notes);
  }
}

List<Slide> parseSlides(String markdown) {
  try {
    final slidesRaws = _splitSlides(markdown);

    return slidesRaws.map((raw) => SlideParser().parse(raw)).toList();
  } on FormatException catch (e) {
    throw SdFormatException(e.message, markdown, e.offset);
  } on SchemaValidationException catch (e) {
    throw SdMarkdownParsingException(e, 0);
  }
}

```

# src/parsers/base_parser.dart

```dart
abstract class Parser<T> {
  T parse(String input);
}

```

# src/parsers/section_parser.dart

```dart
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:superdeck_core/superdeck_core.dart';

List<SectionBlock> parseSections(String markdown) {
  final lines = LineSplitter().convert(markdown);
  var sections = <SectionBlock>[];

  SectionBlock? currentSection;
  var index = 0;

  while (index < lines.length) {
    var line = lines[index];
    final trimmedLine = line.trim();

    if (trimmedLine.startsWith('{@')) {
      // Start of a tag, read until we find the closing '}'
      var tagContent = line;
      while (!tagContent.trim().endsWith('}')) {
        index++;
        if (index >= lines.length) {
          throw Exception('Unclosed tag in markdown');
        }
        tagContent += '\n${lines[index]}';
      }

      // Process the tagContent
      final tagData = extractTagsFromLine(tagContent);

      final blocks = tagData.map(
        (data) => Block.parse(data.blockType, data.options),
      );

      for (final block in blocks) {
        if (block is SectionBlock) {
          // Add the previous section to the list
          if (currentSection != null) {
            sections.add(currentSection);
          }
          // Start a new section
          currentSection = block;
        } else if (block is ColumnBlock) {
          // Add a new subsection to the current section
          currentSection ??= SectionBlock();
          currentSection = currentSection.appendContent(block);
        }
      }
    } else {
      currentSection ??= SectionBlock();

      currentSection = currentSection.appendLine(line);
    }
    index++;
  }

  // Add the last section to the list
  if (currentSection != null) {
    sections.add(currentSection);
  }

  return sections;
}

typedef SyntaxTagData = ({
  BlockType blockType,
  Map<String, dynamic> options,
});

List<SyntaxTagData> extractTagsFromLine(String tagContent) {
  // Parse tags from the line
  final tagRegex = RegExp(r'{@(\w+)(.*?)}', dotAll: true);
  final matches = tagRegex.allMatches(tagContent);

  if (matches.isEmpty) {
    throw Exception('Invalid tag format');
  }

  return matches.map((match) {
    final blockTypeStr = match.group(1);
    var rawOptions = match.group(2) ?? '';

    var blockType = _getBlockType(blockTypeStr!);

    var options = convertYamlToMap(rawOptions);

    // If there is no block treat it as a widget
    if (blockType == null) {
      blockType = BlockType.widget;
      if (options['type'] != null) {
        throw Exception(
          '$blockTypeStr cannot have a property named "type", as it is reserved property.',
        );
      }
      options = {...options, 'name': blockTypeStr};
    }

    return (blockType: blockType, options: options);
  }).toList();
}

BlockType? _getBlockType(String blockTypeStr) {
  return BlockType.values.firstWhereOrNull(
    (e) => e.name == blockTypeStr,
  );
}

// final _imageMarkdownRegex =
//     RegExp(r'!\[(.*?)\]\((.*?)\)(?:\s*\{\.([^\}]+)\})?');

// ImageBlock? parseImageBlock(String markdown) {
//   final match = _imageMarkdownRegex.firstMatch(markdown);
//   if (match == null) {
//     return null;
//   }

//   final url = match.group(2)!;

//   return ImageBlock(
//     src: url,
//   );
// }

```

# src/parsers/front_matter_parser.dart

```dart
import 'dart:convert';

import 'package:superdeck_cli/src/parsers/base_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml/yaml.dart';

typedef MarkdownExtraction = ({
  String contents,
  Map<String, dynamic> frontMatter,
  String key,
});

class FrontMatterParser extends Parser<MarkdownExtraction> {
  @override
  MarkdownExtraction parse(String input) {
    final key = assetHash(input);
    final regex = RegExp(
      r'^---.*\r?\n([\s\S]*?)---',
      multiLine: true,
    );
    final match = regex.firstMatch(input);
    if (match == null) {
      // get everything after the second `---`
      final contents = input.split('---').last;
      return (
        contents: contents.trim(),
        frontMatter: {},
        key: key,
      );
    }

    final yamlString = match.group(1);
    final markdownContent = input.replaceFirst(match.group(0)!, '');

    final yamlMap = loadYaml(yamlString!) as YamlMap?;

    return (
      contents: markdownContent.trim(),
      frontMatter: yamlMap == null ? {} : jsonDecode(jsonEncode(yamlMap)),
      key: key,
    );
  }
}

String serializeYamlFrontmatter(Map<String, dynamic> data) {
  final yamlString = jsonEncode(data);
  return '---\n$yamlString---\n';
}

```

# src/tasks/build_sections_task.dart

```dart
// slide_sections_task.dart

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/parsers/section_parser.dart';

class BuildSectionsTask extends Task {
  BuildSectionsTask() : super('build_sections_task');

  @override
  void run(context) {
    context.slide = context.slide.copyWith(
      sections: parseSections(context.slide.markdown),
    );
  }
}

```

# src/tasks/slide_thumbnail_task.dart

```dart
import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';

/// This task marks the thumbnail file as needed if it exists.
/// The goal is to ensure that any generated thumbnails are kept.
class SlideThumbnailTask extends Task {
  SlideThumbnailTask() : super('thumbnail');

  @override
  FutureOr<TaskContext> run(context) async {
    final file = repository.getSlideThumbnail(context.slide);

    if (await file.exists()) {
      await context.saveAsAsset(file);
    }
    return context;
  }
}

```

# src/tasks/dart_formatter_task.dart

```dart
import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/dart_process.dart';

class DartFormatterTask extends Task {
  DartFormatterTask() : super('dart_formatter');

  @override
  FutureOr<void> run(context) async {
    final formattedMarkdown = _formatDartCodeBlocks(context);

    context.slide = context.slide.copyWith(markdown: formattedMarkdown);
  }

  String _formatDartCodeBlocks(
    TaskContext controller,
  ) {
    final codeBlockRegex = RegExp('```dart\n(.*?)\n```');
    final markdown = controller.slide.markdown;
    return markdown.replaceAllMapped(codeBlockRegex, (match) {
      final code = match.group(1)!;

      final formattedCode = DartProcess.format(code);

      return '```dart\n$formattedCode\n```';
    });
  }
}

```

# src/tasks/image_cache_task.dart

```dart
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// A task responsible for caching images referenced in markdown slides.
class ImageCachingTask extends Task {
  /// Constructs an [ImageCachingTask] with the name 'image_caching'.
  ImageCachingTask() : super('image_caching');

  /// A set to track assets currently being processed to prevent duplicate downloads.
  static final Set<String> _executingAssets = {};

  /// HTTP client used for downloading images.
  static final http.Client _httpClient = http.Client();

  @override
  Future<TaskContext> run(TaskContext context) async {
    final slide = context.slide;
    final content = slide.markdown;

    // Parse the markdown content to extract image URLs.
    final document = md.Document();
    final nodes = document.parseInline(content);
    final Set<String> assets = {};

    for (final node in nodes) {
      if (node is md.Element && node.tag == 'img') {
        final src = node.attributes['src'];
        if (src != null && src.startsWith('http')) {
          assets.add(src);
        }
      }
    }

    // Function to download and save a single asset.
    Future<void> saveAsset(String url) async {
      final String refName = assetHash(url);

      // Check if the asset is already cached.
      if (context.assetExists(refName)) {
        logger.fine('Asset already cached: $url');
        return;
      }

      try {
        logger.info('Downloading asset: $url');
        final response = await _httpClient.get(Uri.parse(url));

        // Verify successful response.
        if (response.statusCode != 200) {
          logger.warning(
            'Failed to download $url: Status ${response.statusCode}',
          );
          return;
        }

        final String? contentType = response.headers['content-type'];
        // Validate content type.
        if (contentType == null || !contentType.startsWith('image/')) {
          logger.warning('Invalid content type for $url: $contentType');
          return;
        }

        // Define supported image formats.
        const List<String> supportedFormats = ['jpeg', 'png', 'gif', 'webp'];
        final String extension = contentType.split('/').last.toLowerCase();

        // Check if the image format is supported.
        if (!supportedFormats.contains(extension)) {
          logger.warning('Unsupported image format for $url: $extension');
          return;
        }

        // Build the asset file and write the downloaded bytes.
        final file = buildAssetFile(refName, extension);
        await file.writeAsBytes(response.bodyBytes);

        // Save the asset in the context.
        await context.saveAsAsset(file, url);
      } catch (e, stackTrace) {
        logger.severe('Error downloading asset $url: $e', e, stackTrace);
      }
    }

    // Iterate over each asset and process if not already executing.
    for (final String asset in assets) {
      if (_executingAssets.contains(asset)) {
        continue; // Skip if the asset is already being processed.
      }
      _executingAssets.add(asset);
      await saveAsset(asset);
      // Optionally, remove the asset from _executingAssets after processing.
      // _executingAssets.remove(asset);
    }

    return context;
  }
}

```

# src/tasks/mermaid_task.dart

```dart
import 'dart:async';
import 'dart:developer';

import 'package:puppeteer/puppeteer.dart';
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_core/superdeck_core.dart';

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

      final mermaidFile = buildAssetFile(
        assetHash(mermaidSyntax),
        'png',
      );

      if (!await mermaidFile.exists()) {
        final browser = await _getBrowser();

        final imageData =
            await generateRoughMermaidGraph(browser, mermaidSyntax);

        await mermaidFile.writeAsBytes(imageData);
      }

      // If file existeed or was create it then replace it
      if (await mermaidFile.exists()) {
        await context.saveAsAsset(mermaidFile);
      }

      final imageMarkdown = '![mermaid](${mermaidFile.path})';

      context.slide = context.slide.copyWith(
        markdown: context.slide.markdown.replaceAll(
          match.group(0)!,
          imageMarkdown,
        ),
      );
    }
  }
}

```

# src/runner.dart

```dart
import 'dart:async';
import 'dart:io';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/helpers/update_pubspec.dart';
import 'package:superdeck_cli/src/tasks/build_sections_task.dart';
import 'package:superdeck_cli/src/tasks/dart_formatter_task.dart';
import 'package:superdeck_cli/src/tasks/image_cache_task.dart';
import 'package:superdeck_cli/src/tasks/mermaid_task.dart';
import 'package:superdeck_cli/src/tasks/slide_thumbnail_task.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:watcher/watcher.dart';

import 'generator_pipeline.dart';

String _previousMarkdownContents = '';

class SuperdeckRunner {
  SuperdeckRunner();

  Future<void> watch() async {
    await build();
    final watchingLabel = 'Watching for changes...';
    logger
      ..newLine()
      ..info(watchingLabel);
    final watcher = FileWatcher(kMarkdownFile.path);
    await for (final event in watcher.events) {
      await _onFileEvent(event, build);
      logger
        ..newLine()
        ..info('Watching for changes...');
    }
  }

  Future<void> _onFileEvent(
    WatchEvent event,
    Future<void> Function() callback,
  ) async {
    if (event.type != ChangeType.MODIFY) return;

    final newContents = await kMarkdownFile.readAsString();

    if (newContents == _previousMarkdownContents) return;

    _previousMarkdownContents = newContents;

    await callback();
  }

  Future<void> build() async {
    final progress = logger.progress('Generating slides...');

    final pipeline = TaskPipeline([
      MermaidConverterTask(),
      DartFormatterTask(),
      SlideThumbnailTask(),
      ImageCachingTask(),
      BuildSectionsTask(),
    ]);
    try {
      final slides = await pipeline.run();
      progress.complete('Generated ${slides.length} slides.');
    } on Exception catch (e, stackTrace) {
      progress.fail();
      _handleException(e);

      logger.detail(stackTrace.toString());
    }
  }

  Future<void> prepareSuperdeck() async {
    final file = File(kPubpsecFile.path);
    final yamlContents = await file.readAsString();
    updatePubspecAssets(yamlContents);
  }
}

void _handleException(Exception e) {
  if (e is SdTaskException) {
    logger
      ..err('slide: ${e.controller.index}')
      ..err('Task error: ${e.taskName}');

    _handleException(e.exception);
  } else if (e is SdFormatException) {
    logger.formatError(e);
  } else if (e is SdMarkdownParsingException) {
    final errorMessages = e.messages.join('\n');
    logger
      ..newLine()
      ..alert(
        'Slide schema validation failed',
      )
      ..newLine()
      ..err(
        'slide ${e.slideLocation}: > ${e.location} > $errorMessages',
      )
      ..newLine();
  } else {
    logger.err(e.toString());
  }
}

```

# src/generator_pipeline.dart

```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

typedef PipelineResult = ({
  List<Slide> slides,
  List<Asset> neededAssets,
});

class TaskContext {
  final int index;
  Slide slide;
  List<Asset> assets;

  TaskContext({
    required this.slide,
    required this.index,
    required this.assets,
  });

  final List<Asset> _neededAssets = [];

  bool assetExists(String assetName) {
    for (var element in assets) {
      print('Checking asset: ${element.path}');
    }
    final asset = assets.firstWhereOrNull(
      (element) => element.path.contains(assetName),
    );

    if (asset == null) {
      return false;
    }

    _neededAssets.add(asset);

    return true;
  }

  Future<void> saveAsAsset(File file, [String? reference]) async {
    final image = await img.decodeImageFile(file.path);

    if (image == null) {
      throw Exception('Image could not be decoded');
    }

    final asset = Asset(
      path: file.path,
      width: image.width,
      height: image.height,
      reference: reference,
    );
    _neededAssets.add(asset);
  }

  Slide finalize() {
    return slide.copyWith(
      assets: _neededAssets,
    );
  }
}

class TaskPipeline {
  final List<Task> tasks;
  final repository = DeckRepository(canRunLocal: true);

  TaskPipeline(
    this.tasks,
  );

  Future<TaskContext> _runEachSlide(
    TaskContext context,
  ) async {
    for (var task in tasks) {
      try {
        await task.run(context);
      } on Exception catch (e) {
        throw SdTaskException(task.name, context, e);
      }
    }

    return context;
  }

  Future<List<Slide>> run() async {
    final markdownRaw = await repository.loadMarkdown();

    // final loadedReference = SuperDeckReference.loadYaml(kReferenceFileYaml);
    final savedSlides = await repository.loadSlides();

    final slides = parseSlides(markdownRaw);
    final assets = savedSlides
        .map((e) => e.assets)
        .expand((e) => e)
        .toList()
        .where((element) => File(element.path).existsSync())
        .toList();

    final futures = <Future<TaskContext>>[];

    for (var i = 0; i < slides.length; i++) {
      final controller = TaskContext(
        index: i,
        slide: slides[i],
        assets: assets,
      );
      futures.add(_runEachSlide(controller));
    }

    final contexts = await Future.wait(futures);

    final finalizedSlides = contexts.map((context) => context.finalize());

    final neededAssets = finalizedSlides.expand((slide) => slide.assets);

    await _cleanupGeneratedFiles(neededAssets);

    for (var task in tasks) {
      await task.dispose();
    }

    final newSlides = finalizedSlides.toList();

    await repository.saveSlides(newSlides);

    return newSlides;
  }
}

Future<void> _cleanupGeneratedFiles(Iterable<Asset> assets) async {
  final files = await _loadGeneratedFiles();
  final neededPaths = assets.map((asset) => asset.path).toSet();

  for (var file in files) {
    if (!neededPaths.contains(file.path)) {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}

abstract class Task {
  final String name;
  final repository = DeckRepository(canRunLocal: true);
  Task(this.name);

  FutureOr<void> run(TaskContext context);

  late final logger = Logger('Task: $name');

  Future<String> dartProcess(String code) async {
    final process = await Process.start('dart', ['format', '--fix'],
        mode: ProcessStartMode.inheritStdio);

    process.stdin.writeln(code);
    process.stdin.close();

    final output = await process.stdout.transform(utf8.decoder).join();
    final error = await process.stderr.transform(utf8.decoder).join();

    if (error.isNotEmpty) {
      throw Exception('Error formatting dart code: $error');
    }

    return output;
  }

  File buildAssetFile(String assetName, String extension) {
    if (p.extension(assetName).isNotEmpty) {
      throw Exception('Asset name should not have an extension');
    }

    if (!extension.startsWith('.')) {
      extension = '.$extension';
    }
    final updatedFileName = ('${name}_$assetName$extension');
    return File(p.join(kGeneratedAssetsDir.path, updatedFileName));
  }

  // Dispose or anything here
  FutureOr<void> dispose() {}
}

Future<List<File>> _loadGeneratedFiles() async {
  final files = <File>[];

  await for (var entity in kGeneratedAssetsDir.list()) {
    if (entity is File) {
      files.add(entity);
    }
  }

  return files;
}

```

# src/helpers/update_pubspec.dart

```dart
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

/// Updates the 'assets' section of a pubspec.yaml file with superdeck paths.
///
/// This function takes a [yamlContent] string representing the contents of a
/// pubspec.yaml file. It parses the YAML, adds the '.superdeck/' and
/// '.superdeck/generated/' paths to the 'assets' section under the 'flutter'
/// key if they don't already exist, and returns the updated YAML as a string.
///
/// Returns the updated pubspec YAML content as a string.
String updatePubspecAssets(String yamlContent) {
  // Parse the YAML content into a map
  final parsedYaml = loadYaml(yamlContent);

  // Get the 'flutter' section from the parsed YAML, or an empty map if it doesn't exist
  final flutterSection =
      {...(parsedYaml['flutter'] ?? {}) as Map}.cast<String, dynamic>();

  // Get the 'assets' list from the 'flutter' section, or an empty list if it doesn't exist
  final assets = flutterSection['assets']?.toList() ?? [];

  // Add the '.superdeck/' path to the assets list if it's not already present
  if (!assets.contains('.superdeck/')) {
    assets.add('.superdeck/');
  }

  // Add the '.superdeck/generated/' path to the assets list if it's not already present
  if (!assets.contains('.superdeck/generated/')) {
    assets.add('.superdeck/generated/');
  }

  // Update the 'assets' key in the 'flutter' section with the modified assets list
  flutterSection['assets'] = assets;

  // Create a new map from the parsed YAML and update the 'flutter' key with the modified section
  final updatedYaml = Map<String, dynamic>.from(parsedYaml)
    ..['flutter'] = flutterSection;

  // Convert the updated YAML map back to a string and return it
  return YamlWriter(allowUnquotedStrings: true).write(updatedYaml);
}

```

# src/helpers/extensions.dart

```dart
import 'dart:io';

import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml_writer/yaml_writer.dart';

extension FileExt on File {
  Future<void> ensureWrite(String content) async {
    if (!await exists()) {
      await create(recursive: true);
    }

    await writeAsString(content);
  }

  Future<void> ensureExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}

extension DirectoryExt on Directory {
  Future<void> ensureExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}

extension SlideX on Slide {
  String toMarkdown() {
    final buffer = StringBuffer();

    final options = this.options?.toMap();

    buffer.writeln('---');
    if (options != null && options.isNotEmpty) {
      buffer.write(YamlWriter().write(options));
    }
    buffer.writeln('---');

    buffer.writeln(markdown);

    return buffer.toString();
  }
}

```

# src/helpers/logger.dart

```dart
import 'package:mason_logger/mason_logger.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';

final logger = Logger(
  // Optionally, specify a log level (defaults to Level.info).
  level: Level.info,
  // Optionally, specify a custom `LogTheme` to override log styles.
  theme: LogTheme(),
);

extension LoggerX on Logger {
  void formatError(SdFormatException exception) {
    final message = exception.message;
    final source = exception.source;

    final arrow = _createArrow(exception.columnNumber ?? 0);

    final splitLines = source.split('\n');

    // Get the longes line
    final longestLine = splitLines.fold<int>(0, (prev, element) {
      return element.length > prev ? element.length : prev;
    });

    String padline(String line, [int? index]) {
      final pageNumber = index != null ? '${index + 1}' : ' ';
      return ' $pageNumber | ' + line.padRight(longestLine + 2);
    }

    // Print the error message with the source code
    newLine();
    err('Formatting Error:');
    newLine();
    info(
        '$message on line ${exception.lineNumber}, column ${exception.columnNumber}');
    newLine();

    final exceptionLineNumber = exception.lineNumber ?? 0;

    // Calculate only 4 lines before and after the error line
    final start = (exceptionLineNumber - 5).clamp(0, splitLines.length);
    final end = (exceptionLineNumber + 5).clamp(0, splitLines.length);

    for (int i = 0; i < splitLines.length; i++) {
      final lineNumber = i + 1;
      final currentLineContent = splitLines[i];
      final isErrorLine = lineNumber == exception.lineNumber;

      if (lineNumber < start || lineNumber > end) {
        continue;
      }

      if (isErrorLine) {
        info(padline(currentLineContent, i), style: _highlightLine);
        info(padline(arrow), style: _highlightLine);
      } else {
        _formatCodeBlock(padline(currentLineContent, i));
      }
    }
  }

  void _formatCodeBlock(String message) {
    info(message, style: _formatErrorStyle);
  }

  void newLine() => info('');
}

String _createArrow(int column) {
  return ' ' * (column - 1) + '^';
}

String? _formatErrorStyle(String? m) {
  return backgroundDefault.wrap(styleBold.wrap(white.wrap(m)));
}

String? _highlightLine(String? m) {
  return backgroundDefault.wrap(styleBold.wrap(yellow.wrap(m)));
}

```

# src/helpers/pretty_json.dart

```dart
import 'dart:convert';

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

```

# src/helpers/exceptions.dart

```dart
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_core/superdeck_core.dart';

class SdMarkdownParsingException implements Exception {
  final SchemaValidationException exception;
  final int slideLocation;

  SdMarkdownParsingException(this.exception, this.slideLocation);

  String get location => exception.result.path.join(' | ');

  List<String> get messages {
    return exception.result.errors.map((e) => e.message).toList();
  }
}

class SdTaskException implements Exception {
  final String taskName;
  final TaskContext controller;
  final Exception exception;

  SdTaskException(
    this.taskName,
    this.controller,
    this.exception,
  );

  String get message {
    return 'Error running task on slide ${controller.index}';
  }

  @override
  String toString() => message;
}

class SdFormatException implements Exception {
  final String message;
  final int? offset;
  final String source;

  SdFormatException(
    this.message, [
    this.source = '',
    this.offset,
  ]);

  int? get lineNumber {
    return source.substring(0, offset).split('\n').length;
  }

  String? get lineContent {
    return source.split('\n')[lineNumber! - 1];
  }

  int? get columnNumber {
    final lines = source.split('\n');
    int totalOffset = 0;

    for (int i = 0; i < lineNumber! - 1; i++) {
      // +1 for the newline character
      totalOffset += lines[i].length + 1;
    }

    // Convert zero-based index to one-based
    return offset! - totalOffset + 1;
  }

  @override
  String toString() {
    return message;
  }
}

```

# src/helpers/dart_process.dart

```dart
import 'dart:convert';
import 'dart:io';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_core/superdeck_core.dart';

class DartProcess {
  // static Future<Process> _run(List<String> args) async {
  //   return Process.start('dart', args, mode: ProcessStartMode.inheritStdio);
  // }

  // runSync
  static ProcessResult _runSync(List<String> args) {
    return Process.runSync('dart', args);
  }

  static String format(String code) {
    final hash = assetHash(code); // Generate a hash for the code
    final tempFile = File('${Directory.systemTemp.path}/$hash.dart');
    try {
      tempFile.createSync(recursive: true);

      tempFile.writeAsStringSync(code);

      final result = _runSync(['format', '--fix', tempFile.path]);

      if (result.exitCode != 0) {
        throw _handleFormattingError(result.stderr as String, code);
      }
      return tempFile.readAsStringSync();
    } finally {
      if (tempFile.existsSync()) {
        tempFile.deleteSync();
      }
    }
  }
}

SdFormatException _handleFormattingError(String stderr, String source) {
  final match =
      RegExp(r'line (\d+), column (\d+) of .*: (.+)').firstMatch(stderr);

  if (match != null) {
    final line = int.parse(match.group(1)!);
    final column = int.parse(match.group(2)!);
    final message = match.group(3)!;

    // Calculate the zero-based offset
    final lines = LineSplitter().convert(source);
    int offset = 0;

    // Calculate the offset by summing the lengths of all preceding lines
    for (int i = 0; i < line - 1; i++) {
      offset += lines[i].length + 1; // +1 for the newline character
    }
    offset += column - 1; // Add the column offset within the line

    return SdFormatException(
      'Dart code formatting error: $message',
      source,
      offset,
    );
  } else {
    return SdFormatException('Error formatting dart code: $stderr');
  }
}

```


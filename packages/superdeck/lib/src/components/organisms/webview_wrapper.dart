import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWrapper extends StatefulWidget {
  final String url;

  WebViewWrapper({super.key, required this.url});

  final _uniqueKey = GlobalKey();

  @override
  _WebViewWrapperState createState() => _WebViewWrapperState();
}

class _WebViewWrapperState extends State<WebViewWrapper>
    with AutomaticKeepAliveClientMixin {
  late WebViewController _controller;
  bool _hide = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    (widget._uniqueKey).currentState?.dispose();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    _controller.loadRequest(Uri.parse(widget.url));
  }

  Future<void> executeInIframe(String code) {
    return _controller.runJavaScript(code);
  }

  Future<void> clearDartPadEditor() {
    _controller.reload();
    return executeInIframe('''
                var editor = document.querySelector('.CodeMirror')?.CodeMirror;
                if (editor) {
                  editor.setValue('');
                  editor.setCursor({line: 0, ch: 0});
                  editor.focus();
                  console.log('DartPad editor cleared!');
                }
            ''');
  }

  // Function to set content in the DartPad editor
  Future<void> setDartPadEditorContent(String content) {
    return executeInIframe('''
                var editor = document.querySelector('.CodeMirror')?.CodeMirror;
                if(editor){
                  editor.setValue($content);
                  editor.setCursor(editor.lineCount(), 0);
                  editor.focus();
                  console.log('DartPad editor content set!');
                }
            ''');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(key: ValueKey(_hide), controller: _controller),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _hide = !_hide;
                });
              },
              icon: const Icon(Icons.refresh),
            ),
            // add button that clears the webview by running javascript
            IconButton(
              onPressed: clearDartPadEditor,
              icon: const Icon(Icons.clear),
            ),
          ],
        )
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  final controller = Completer<WebViewController>();
  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url, controller);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  var loadingPercentage = 0;
  _WebViewContainerState(this._url, this.controller);
  // WebViewStack({required this.controller, super.key}); // Modify

  final Completer<WebViewController> controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebView'),
          actions: [
            NavigationControls(controller: controller),
          ],
        ),
        body: Stack(
          children: [
            WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: _createJavascriptChannels(context),
              initialUrl: _url,
              onWebViewCreated: (webViewController) {
                widget.controller.complete(webViewController);
              },
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  loadingPercentage = 100;
                });
              },
              navigationDelegate: (navigation) {
                final host = Uri.parse(navigation.url).host;
                if (host.contains('youtube.com')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Blocking navigation to $host',
                      ),
                    ),
                  );
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                color: Colors.orange,
                value: loadingPercentage / 100.0,
              ),
          ],
        ));
  }
}

Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
  return {
    JavascriptChannel(
      name: 'SnackBar',
      onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      },
    ),
  };
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, key});

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return Row(
            children: const <Widget>[
              Icon(Icons.arrow_back_ios),
              Icon(Icons.arrow_forward_ios),
              Icon(Icons.replay),
            ],
          );
        }

        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}

class BackEventNotifier extends ChangeNotifier {
  bool isback = true;
  bool get isBack => isback;
  void add(bool value) {
    isback = value;
    notifyListeners();
  }
}

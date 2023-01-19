

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/webview/cubit/cubit.dart';
import 'package:rxcommon/presentation/webview/cubit/webview_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../common/appbar/item_appbar_smallheader.dart';

class WebViewPage extends StatefulWidget {
 final String _links;
 final String  title;
  WebViewPage(this._links, this.title);
  @override
  State<WebViewPage> createState() => _WebViewPage(_links,title);
  
}


class _WebViewPage extends State<WebViewPage>  {
 final _links;
 final String title;
  _WebViewPage(this._links, this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<WebviewCubit>(
          create: (_) => WebviewCubit(), child: Webviewpage(this._links, this.title)),
    );
  }
}

class Webviewpage extends StatefulWidget {
  final url;
 String title ="";
  Webviewpage(this.url, this.title);

  @override
  createState() => _WebviewpageState(this.url, this.title);
}

class _WebviewpageState extends State<Webviewpage> {
  late WebViewController _controll;

  GlobalKey _globalKey = GlobalKey();

  var _url, _title;
  final _key = UniqueKey();
  var loadingPercentage = 0;
  _WebviewpageState(this._url, this._title);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebviewCubit, WebviewState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () =>
              BlocProvider.of<WebviewCubit>(context).onBack(_controll),
          child: Container(
            decoration: const BoxDecoration(
           image: DecorationImage(
              image: AssetImage("assets/images/home_bg.png"),
              fit: BoxFit.fill)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              key: _globalKey,
              appBar: appbarSmall(context,_title) ,
              body: WebView(
                initialUrl: _url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (webViewController) {
                  _controll = webViewController;
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                },
                javascriptChannels: {
                  _toasterJavascriptChannel(context),
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url ==
                      "https://github.com/flutter/flutter/issues") {
                    return NavigationDecision.navigate;
                  }
                  if (request.url.contains("umuieme")) {
                    return NavigationDecision.navigate;
                  }
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              ),
            ),
          ),
        );
      },
    );
  }
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        // Scaffold.of(context).showSnackBar(
        //   SnackBar(content: Text(message.message)),
        // );
      });
}

/* class BackEventNotifier extends ChangeNotifier {
  bool isback = true;
  bool get isBack => isback;
  void add(bool value) {
    isback = value;
    notifyListeners();
  }
} */

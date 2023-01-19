import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/webview/cubit/webview_cubit.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/presentation/home/view/giftshopwidget.dart';
import 'package:vnu/presentation/more/more_page.dart';
import 'package:vnu/presentation/webview/webview.dart';
import '../../../injection.dart';
import '../../webview/web_view_container.dart';
import 'interestwidget.dart';
import 'quickviewwidget.dart';
import 'myrewardswidgetnr.dart';
import 'package:rxcommon/presentation/presentation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ItemBloc itemBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(LocalImages.homebg), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.titlewelcome,
              style: CustomTextStyle.getAppBarTitleStyle(Colors.white)),
          leading: GestureDetector(
            onTap: () {
              print('More is clicked');
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => MorePage()));
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.more);
            },
            child: Icon(
              Icons.menu,
              size: Constant.drawericonSize, // add custom icons also
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/2.8 ,//Constant.quickviewwidget,
              //    height: Constant.quickviewwidget,
                
              /*    child: BlocProvider(
                    create: (_) => QuickViewBloc(locator()),
                    child: QuickViewItem()),**/
              ),
              MyRewardWidgetNR(),
              //   InterestStateWidget(),

           /*   BlocProvider(
                  create: (_) => GiftShopBloc(locator()),
                  child: const GiftshopList()),

              BlocProvider(
                  create: (_) => InterestBloc(locator()),
                  child: const InterestList()),**/

              // WebView1(),
              //  WebView(),
            ],
          ),
        ),
      ),
    );
  }
}

/* class WebView1 extends StatelessWidget {
  final _links = ['https://camellabs.com'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _links.map((link) => _urlButton(context, link)).toList(),
    ));
  }

  Widget _urlButton(BuildContext context, String url) {
    return Container(
        height: 100,
        padding: EdgeInsets.all(20.0),
        child: ElevatedButton(
          child: Text(url + " with bloc"),
          onPressed: () => _handleURLButtonPress(context, url),
        ));
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewPage(_links)));
  }
}

class WebView extends StatelessWidget {
  final _links = ['https://flutter.dev/'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _links.map((link) => _urlButton(context, link)).toList(),
    ));
  }

  Widget _urlButton(BuildContext context, String url) {
    return Container(
        height: 100,
        padding: EdgeInsets.all(20.0),
        child: ElevatedButton(
          child: Text(url),
          onPressed: () => _handleURLButtonPress(context, url),
        ));
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
 */
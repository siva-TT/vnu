import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/presentation.dart';
import 'package:vnu/injection.dart';
import 'package:vnu/presentation/common/widgets/item_card_widget.dart';
import 'package:vnu/presentation/common/widgets/item_interest_widget.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';

class GiftshopListPage extends StatefulWidget {
  
 final String itemType;
 final String  title;
  GiftshopListPage(this.itemType, this.title);

  @override
  State<GiftshopListPage> createState() => _GiftshopListPageState(itemType, title);
}

class _GiftshopListPageState extends State<GiftshopListPage> {
  
  final String itemType;
 final String  title;
  _GiftshopListPageState(this.itemType, this.title);
  @override
  Widget build(BuildContext context) {
    
     return  HomeScaffold(
        context, title, "", blocProvider(itemType, title),1);
  
  
  }
}
Widget blocProvider(itemType, title) {
  return BlocProvider(
              create: (_) => GiftShopBloc(locator()),
              child: GiftshopList(itemType, title));
}
class GiftshopList extends StatefulWidget {
  
  final String itemType;
 final String  title;
  GiftshopList(this.itemType, this.title);
  @override
  State<GiftshopList> createState() => _GiftshopListState(itemType, title);
}

class _GiftshopListState extends State<GiftshopList> {

List<dynamic> dynList =[];
  final String itemType;
 final String  title;
  _GiftshopListState(this.itemType, this.title);

  @override
  void initState() {
    super.initState();
   getGiftshop();
  }

  Future<void> getGiftshop() async {
    context.read<GiftShopBloc>().add(GiftShopFetched());
  }

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<GiftShopBloc, GiftShopState>(builder: (context, state) {
      if (state.status == GiftShopStatus.initial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == GiftShopStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == GiftShopStatus.error) {
        return  emptyAlert(context,title);
      }

      return RefreshIndicator(
      onRefresh: () =>   getGiftshop(),
        child: Column(children: <Widget>[
          Container(
            child: Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  key: const Key('Item data'),
                  itemCount: state.posts.length,
                   itemBuilder: (BuildContext ctx, index) {
                     return ItemCard(
                        title: state.posts[index].title,
                        previewImagePath: state.posts[index].previewImagePath,
                        actionDescription: "",
                        itemType: "",
                        sysId: "",
                        transId: state.posts[index].transactionId,
                        extUrl: "",
                        description: state.posts[index].description,
                        startDate: state.posts[index].startDate,
                        endDate: state.posts[index].endDate,
                        interest: dynList);
                    return ItemInterest(
                        title: state.posts[index].title,
                        previewImagePath: state.posts[index].previewImagePath,
                        actionDescription: "",
                        itemType: "",
                        sysId: "",
                        transId: state.posts[index].transactionId,
                        extUrl: "");
                  },),
            ),
          )
        ]),
      );
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxcommon/presentation/presentation.dart';
import 'package:vnu/constant/strings.dart';

import 'package:vnu/injection.dart';
import 'package:vnu/presentation/common/widgets/item_card_widget.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';


class WhatsonPage extends StatefulWidget {
  const WhatsonPage({Key? key}) : super(key: key);

  @override
  State<WhatsonPage> createState() => _WhatsonPageState();
}

class _WhatsonPageState extends State<WhatsonPage> {
  late final ItemBloc itemBloc;
  @override
  Widget build(BuildContext context) {
    return  HomeScaffold(
        context, Strings.titleWhatson, "promotion_header.png", blocProvider(),0);
        }
}

Widget blocProvider() {
  return BlocProvider(
      create: (_) => ItemBloc(locator()), child: const FavouriteList());
}

class FavouriteList extends StatefulWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  void initState() {
    super.initState();
    getItem();
  }

  Future<void> getItem() async {
    context.read<ItemBloc>().add(ItemFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
      if (state.status == ItemStatus.initial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == ItemStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
 if (state.status == ItemStatus.error) {
        return   emptyResponse(context, Strings.nowhatson);
      }
     

      return RefreshIndicator(
        onRefresh: getItem,
        child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                key: const Key('Item data'),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                      title: state.posts[index].title,
                      previewImagePath: state.posts[index].previewImagePath,
                      actionDescription: state.posts[index].actionDescription,
                      itemType: state.posts[index].itemType,
                      sysId: state.posts[index].venueid,
                      transId: state.posts[index].transacId,
                      extUrl: state.posts[index].extUrl,
                      description: state.posts[index].description,
                      startDate: state.posts[index].startDate,
                      endDate: state.posts[index].endDate,
                      interest: state.posts[index].interest);
                }),
          )
        ]),
      );
    });
  }
}

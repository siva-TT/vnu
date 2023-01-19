import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxcommon/presentation/presentation.dart';

import 'package:vnu/injection.dart';
import 'package:vnu/presentation/common/widgets/item_card_widget.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';

class FacilitiesPage extends StatefulWidget {
  
 final String itemType;
 final String  title;
  FacilitiesPage(this.itemType, this.title);

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState(itemType, title);
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  
  final String itemType;
 final String  title;
  _FacilitiesPageState(this.itemType, this.title);
  @override
  Widget build(BuildContext context) {
    
     return  HomeScaffold(
        context, title, "", blocProvider(itemType, title),1);
  
  
  }
}
Widget blocProvider(itemType, title) {
  return BlocProvider(
              create: (_) => FacilitiesBloc(locator()),
              child: FacilitiesList(itemType, title));
}
class FacilitiesList extends StatefulWidget {
  
  final String itemType;
 final String  title;
  FacilitiesList(this.itemType, this.title);
  @override
  State<FacilitiesList> createState() => _FacilitiesListState(itemType, title);
}

class _FacilitiesListState extends State<FacilitiesList> {


  final String itemType;
 final String  title;
  _FacilitiesListState(this.itemType, this.title);

  @override
  void initState() {
    super.initState();
    getFacilities(itemType);
  }

  Future<void> getFacilities(String itemType) async {
    context.read<FacilitiesBloc>().add(FacilitiesFetched(itemType));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacilitiesBloc, FacilitiesState>(builder: (context, state) {
      if (state.status == FacilitiesStatus.initial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == FacilitiesStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == FacilitiesStatus.error) {
        return  emptyAlert(context,title);
      }

      return RefreshIndicator(
      onRefresh: () =>   getFacilities(itemType),
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

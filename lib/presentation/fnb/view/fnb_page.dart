import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/presentation.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/injection.dart';
import 'package:vnu/presentation/common/widgets/item_card_widget.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';

class FnbPage extends StatefulWidget {
  const FnbPage({Key? key}) : super(key: key);

  @override
  State<FnbPage> createState() => _FnbPageState();
}

class _FnbPageState extends State<FnbPage> {
  late final ItemBloc itemBloc;
  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        context, Strings.titlefnb, "fnb_header.png", blocProvider(),0);
  }
}

Widget blocProvider() {
  return BlocProvider(
      create: (_) => FnbBloc(locator()), child: const FnbList());
}

class FnbList extends StatefulWidget {
  const FnbList({Key? key}) : super(key: key);

  @override
  State<FnbList> createState() => _FnbListState();
}

class _FnbListState extends State<FnbList> {
  @override
  void initState() {
    super.initState();
    getFnb();
  }

  Future<void> getFnb() async {
    context.read<FnbBloc>().add(FnbFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FnbBloc, FnbState>(builder: (context, state) {
      if (state.status == FnbStatus.initial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == FnbStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == FnbStatus.error) {
        return emptyResponse(context, Strings.noFnb);
      }

      return RefreshIndicator(
        onRefresh: getFnb,
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

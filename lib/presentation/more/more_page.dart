
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/presentation.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/injection.dart';
import 'package:vnu/presentation/common/widgets/item_more_widget.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late final ItemBloc itemBloc;
  @override
  Widget build(BuildContext context) {
     return  HomeScaffold(
        context, Strings.titleMore, "", blocProvider(),1);
        }
}
Widget blocProvider() {
  return BlocProvider(
      create: (_) => MoreBloc(locator()), child: const MoreList());
}
class MoreList extends StatefulWidget {
  const MoreList({Key? key}) : super(key: key);

  @override
  State<MoreList> createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {
  @override
  void initState() {
    super.initState();
    getMore();
  }

  Future<void> getMore() async {
    context.read<MoreBloc>().add(MoreFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(builder: (context, state) {
      if (state.status == MoreStatus.initial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == MoreStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == MoreStatus.error) {
        return   emptyResponse(context, Strings.noMoreItem);
      }

      return RefreshIndicator(
        onRefresh: getMore,
        child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                key: const Key('Item data'),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                
                  return ItemMore(
                      title: state.posts[index].title,
                      previewImagePath: state.posts[index].previewImagePath,
                       actionDescription: state.posts[index].actionDescription, 
                       itemType: state.posts[index].itemType,
                        sysId: state.posts[index].venueid,
                         transId: state.posts[index].transacId,
                         extUrl: state.posts[index].extUrl);

                }),
          )
        ]),
      );
    });
  }
}

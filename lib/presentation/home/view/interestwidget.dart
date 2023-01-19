import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/lib.dart';
import 'package:rxcommon/presentation/items/bloc/item_bloc.dart';
import 'package:vnu/constant/constant.dart';

import 'package:vnu/constant/custom_text_style.dart';

import '../../common/widgets/item_interest_widget.dart';

class InterestList extends StatefulWidget {
  const InterestList({Key? key}) : super(key: key);

  @override
  State<InterestList> createState() => _InterestListState();
}

class _InterestListState extends State<InterestList> {
  @override
  void initState() {
    super.initState();
    getInterest();
  }

  Future<void> getInterest() async {
    context.read<InterestBloc>().add(InterestFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterestBloc, InterestState>(builder: (context, state) {
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
        return const Text(
          "errorr",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      return Row(
        children: [
          Expanded(
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.interests.keys.length,
                itemBuilder: (context, indexMain) {
                  List list = state
                      .interests[state.interests.keys.elementAt(indexMain)];
                  return Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: Constant.padding15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.interests.keys
                              .elementAt(indexMain)
                              .toString()
                              .toUpperCase(),
                          textAlign: TextAlign.start,
                          style: CustomTextStyle.getTitleStyle(Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: Constant.homeWidgetImage,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: list
                                      .length, // state.interests[state.interests.keys.elementAt(indexMain).toString()],
                                  itemBuilder: (context, index) {
                                    return ItemInterest(
                                        title: list[index].title,
                                        previewImagePath:
                                            list[index].previewImagePath,
                                        actionDescription:
                                            list[index].actionDescription,
                                        itemType: list[index].itemType,
                                        sysId: list[index].venueid,
                                        transId: list[index].transacId,
                                        extUrl: list[index].extUrl);
                                  }),
                            )
                          ]),
                        )),
                  ]);
                }),
          ),
        ],
      );
    });
  }
}

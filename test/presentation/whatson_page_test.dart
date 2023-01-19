import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vnu/presentation/whatson/view/whatson_page.dart';


import 'package:rxcommon/lib.dart';

class MockItemBloc extends MockBloc<ItemEvent, ItemState> implements ItemBloc {}

class FakeItemState extends Fake implements ItemState {}

class FakeItemEvent extends Fake implements ItemEvent {}

void main() {
  late MockItemBloc mockItemBloc;
  // ItemModel fv1 = ItemModel(
  //     title: "New Comp create with Enhanced preview1",
  //     description: "Next Swipe",
  //     startDate: "2022-07-06T00:00:00",
  //     endDate: "2022-07-06T23:59:59",
  //     previewImagePath:
  //         "https://rxdevds.blob.core.windows.net/venuemetro/MemberAppTransactions/32642/62c4f1b69d7a1.png", interest: ["Eat","Drinl"]);

  // ItemModel fv2 = ItemModel(
  //     title: "New Comp with Eticket and NextSwipe",
  //     description: "Comp with Eticket and NextSwipe",
  //     startDate: "2022-07-06T00:00:00",
  //     endDate: "2022-07-06T23:59:59",
  //     previewImagePath: "", interest: ["Eat","Drinl"]);

  List<ItemEntity> ItemPosts = [];

  // ItemPosts.add(fv1);
  // ItemPosts.add(fv2);
  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeItemState());
    registerFallbackValue(FakeItemEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockItemBloc);
  });

  setUp(() {
    mockItemBloc = MockItemBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<ItemBloc>.value(
      value: mockItemBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets("checking initial", (WidgetTester tester) async {
    when(() => mockItemBloc.state).thenReturn(ItemState(
      status: ItemStatus.initial,
    ));

    await tester.pumpWidget(_makeTestableWidget(FavouriteList()));

    // assert
    expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
  });

  testWidgets("checking loading", (WidgetTester tester) async {
    when(() => mockItemBloc.state).thenReturn(ItemState(
      status: ItemStatus.loading,
    ));

    await tester.pumpWidget(_makeTestableWidget(FavouriteList()));

    // assert
    expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
  });

  testWidgets("Loading data", (WidgetTester tester) async {
    when(() => mockItemBloc.state)
        .thenReturn(ItemState(status: ItemStatus.success, posts: ItemPosts));

    await tester.pumpWidget(_makeTestableWidget(FavouriteList()));

    // assert
    expect(find.byKey(Key('Item data')), equals(findsOneWidget));
  });

    testWidgets("data refresh", (WidgetTester tester) async {
    when(() => mockItemBloc.state)
        .thenReturn(ItemState(status: ItemStatus.success, posts: ItemPosts));

    await tester.pumpWidget(_makeTestableWidget(FavouriteList()));  

    await tester.fling(find.byKey(Key('Item data')), const Offset(0.0, 300.0), 1000.0);
    await tester.pump();

    expect(
        tester.getSemantics(find.byType(RefreshProgressIndicator)),
        matchesSemantics(
       label: 'Refresh'
        ));   
   
  });
}

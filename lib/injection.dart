import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rxcommon/domain/usecases/items/get_facilities.dart';
import 'package:rxcommon/domain/usecases/items/get_more.dart';
import 'package:rxcommon/lib.dart';

final locator = GetIt.instance;

void init() {
   locator.registerFactory(() => FacilitiesBloc(locator()));
  locator.registerLazySingleton(() => GetFacilities(repository: locator()));
     locator.registerFactory(() => FnbBloc(locator()));
  locator.registerLazySingleton(() => GetFnb(repository: locator()));
   locator.registerFactory(() => MoreBloc(locator()));
  locator.registerLazySingleton(() => GetMore(repository: locator()));
  locator.registerFactory(() => QuickViewBloc(locator()));
  locator.registerLazySingleton(() => GetQuickView(repository: locator()));
  locator.registerFactory(() => GiftShopBloc(locator()));
  locator.registerLazySingleton(() => GetGiftShop(repository: locator()));
  locator.registerFactory(() => ItemBloc(locator()));
  locator.registerLazySingleton(() => GetItem(repository: locator()));
  locator.registerFactory(() => InterestBloc(locator()));
  locator.registerLazySingleton(() => GetInterests(repository: locator()));
  locator.registerLazySingleton<ItemRepository>( () => ItemRepositoryImpl(itemDataSource: locator()));
  locator.registerLazySingleton<ItemDataSource>( () => ItemDataSourceImpl(client: locator()));
  locator.registerLazySingleton<GiftshopRepository>(() => GiftShopRepositoryImpl(giftshopDataSource: locator()));
  locator.registerLazySingleton<GiftshopDataSource>(() => GiftshopDataSourceImpl(client: locator()));
  locator.registerLazySingleton(() => http.Client());
}

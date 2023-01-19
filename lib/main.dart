import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vnu/presentation/common/root_screen.dart';
import 'package:vnu/presentation/home/view/home_page.dart';
import 'package:vnu/simple_bloc_observer.dart';
import 'package:vnu/theme/theme.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constant/applog.dart';
import 'firebase_options.dart';
import 'package:rxcommon/presentation/navigation/navigation.dart';
import 'injection.dart' as di;

void main() async {
  di.init();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Applog.printlog(
          'onMessage: $message.data notification  $message.notification');
    });

    BlocOverrides.runZoned(
      () => runApp(const App()),
      blocObserver: SimpleBlocObserver(),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });

  //  CatcherOptions debugOptions =
  //     CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

  // CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
  //   EmailManualHandler(["fctplmdu@gmail.com"])
  // ]);

  // /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  // Catcher(rootWidget: App(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

Future<void> _messageHandler(RemoteMessage message) async {
  Applog.printlog(
      'background message received ${message.notification!.body} ${message.data}');
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(

          //navigatorKey : Catcher.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: SafeArea(
            child: CustomWidgetExample()
            // child: HomePage(),
          )),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:the_open_quran/l10n/app_localizations.dart';
import 'package:the_open_quran/providers/app_settings_provider.dart';
import 'package:the_open_quran/providers/bookmark_provider.dart';
import 'package:the_open_quran/providers/favorites_provider.dart';
import 'package:the_open_quran/providers/player_provider.dart';
import 'package:the_open_quran/providers/quran_provider.dart';
import 'package:the_open_quran/providers/search_provider.dart';
import 'package:the_open_quran/screens/bottom_nav_bar_screen.dart';
import 'package:the_open_quran/themes/theme.dart';

import 'main_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:456277928487:android:6885c55a3b34746750bc02',
      apiKey: 'AIzaSyCF-AmpOiZ1zCjdrggrzgu643OGvDdXvlU',
      projectId: 'al-quran-app-7aa07',
      messagingSenderId: '456277928487',
      storageBucket: 'al-quran-app-7aa07.firebasestorage.app',
    ),
  );

  OneSignal.initialize(
    'c0bfd2f0-00f7-4927-a079-0f0fee5e2e3b',
  );
  
  await GetStorage.init('Al-Quran');
  //debugRepaintRainbowEnabled = false;
  // Pass all uncaught errors from the framework to Crashlytics.
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AppSettingsProvider>(
        builder: (context, appSettingProvider, child) {
          return MaterialApp(
            title: "Al Qur'an",
            debugShowCheckedModeBanner: false,
            locale: appSettingProvider.appLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: MainBuilder.builder,
            localeResolutionCallback:
                appSettingProvider.localeResolutionCallback,
            theme: theme,
            home: const BottomNavBarScreen(),
          );
        },
      ),
    );
  }

  /// Create App Global Providers
  List<SingleChildWidget> get providers {
    return [
      ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
      ChangeNotifierProvider(create: (_) => QuranProvider(), lazy: false),
      ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider(_)),
    ];
  }
}

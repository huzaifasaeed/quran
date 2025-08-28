import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:the_open_quran/constants/app_update.dart';
import 'package:the_open_quran/screens/settings_screen.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../constants/padding.dart';
import '../providers/home_provider.dart';
import '../providers/more_provider.dart';
import '../providers/player_provider.dart';
import '../providers/search_provider.dart';
import '../widgets/bars/play_bar.dart';
import '../widgets/cards/slidable_verse_card/slidable_provider.dart';
import 'bookmark_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlayerProvider>().createAudioHandler(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestNotificationPermission();
      AppUpdate.versionCheck(context);
      // mergeJsonFiles();
    });
  }

  // Future<void> mergeJsonFiles() async {
  //   try {
  //     // Load indopak.json and quran.json from assets
  //     String indopakJsonString = await DefaultAssetBundle.of(context)
  //         .loadString('assets/json/indopak.json');
  //     String uthmaniTajweedJsonString = await DefaultAssetBundle.of(context)
  //         .loadString('assets/json/uthmani_tajweed.json');
  //     String quranJsonString =
  //         await DefaultAssetBundle.of(context).loadString('assets/json/quran.json');

  //     // Parse JSON strings
  //     Map<String, dynamic> indopakData = jsonDecode(indopakJsonString);
  //     Map<String, dynamic> uthmaniTajweedData = jsonDecode(uthmaniTajweedJsonString);
  //     List<dynamic> quranData = jsonDecode(quranJsonString);

  //     // Create a map for quick lookup of text_indopak by verse_key
  //     Map<String, String> indopakDict = {
  //       for (var verse in indopakData['verses'])
  //         verse['verse_key']: verse['text_indopak']
  //     };
  //     Map<String, String> uthmaniTajweedDict = {
  //       for (var verse in uthmaniTajweedData['verses'])
  //         verse['verse_key']: verse['text_uthmani_tajweed']
  //     };

  //     // Iterate through quran.json to insert text_indopak
  //     for (var surah in quranData) {
  //       for (var verse in surah['verses']) {
  //         String verseKey = verse['verse_key'];
  //         if (indopakDict.containsKey(verseKey)) {
  //           verse['text_indopak'] = indopakDict[verseKey];
  //         }
  //         if (uthmaniTajweedDict.containsKey(verseKey)) {
  //           verse['text_uthmani_tajweed'] = uthmaniTajweedDict[verseKey];
  //         }
  //       }
  //     }

  //     // Get the temporary directory to save the updated file
  //     Directory? docDir = await getDownloadsDirectory();
  //     File outputFile = File('${docDir!.path}/quran_updated.json');

  //     // Write the updated quran.json
  //     await outputFile.writeAsString(jsonEncode(quranData), encoding: utf8);
  //     print(outputFile.absolute.path);
  //     // setState(() {
  //     //   _status = 'Merge successful! File saved to: ${outputFile.path}';
  //     // });
  //   } catch (e) {
  //     // setState(() {
  //     //   _status = 'Error: $e';
  //     // });
  //   }
  // }

  Future<void> _requestNotificationPermission() async {
    try {
      await OneSignal.Notifications.requestPermission(true);
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting notification permission: $e');
      }
    }
  }

  /// Current index of bottom navigation bar
  int currentIndex = 0;

  /// Changes index of bottom navigation Bar
  changeIndex(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => HomeProvider(context), lazy: false),
        ChangeNotifierProvider(create: (_) => MoreProvider(context)),
        ChangeNotifierProvider(create: (_) => SearchProvider(context)),
        ChangeNotifierProvider(create: (_) => SlidableProvider(context)),
      ],
      child: Scaffold(
        body: buildBody,
        bottomNavigationBar: buildBottomNavigationBar,
      ),
    );
  }

  /// Stack pages of the [BottomNavigationBar]
  Widget get buildBody {
    return IndexedStack(
      index: currentIndex,
      children: const [
        HomeScreen(),
        BookmarkScreen(),
        FavoritesScreen(),
        SettingsScreen(),
      ],
    );
  }

  Widget get buildBottomNavigationBar {
    return buildBottomBarBackGround(
      child: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: changeIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          buildBottomNavigationBarItem(
            icon: ImageConstants.homeInactiveIcon,
            activeIcon: ImageConstants.homeActiveIcon,
          ),
          buildBottomNavigationBarItem(
            icon: ImageConstants.bookmarkInactiveIcon,
            activeIcon: ImageConstants.bookmarkActiveIcon,
          ),
          buildBottomNavigationBarItem(
            icon: ImageConstants.favoriteInactiveIcon,
            activeIcon: ImageConstants.favoriteActiveIcon,
          ),
          buildBottomNavigationBarItem(
            icon: ImageConstants.moreInactiveIcon,
            activeIcon: ImageConstants.moreActiveIcon,
          )
        ],
      ),
    );
  }

  Widget buildBottomBarBackGround({required Widget child}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PlayBar(),
        Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.white.withOpacity(0.07),
              AppColors.white.withOpacity(0.12),
            ],
          )),
        ),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 64.0, sigmaY: 64.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.black4.withOpacity(0.47),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.05),
                    offset: const Offset(0.0, 45.024),
                    blurRadius: 72.36,
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String icon,
    required String activeIcon,
  }) {
    double padding = Platform.isIOS ? kSizeM : 0;
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: padding),
        child: SvgPicture.asset(
          icon,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.only(top: padding),
        child: SvgPicture.asset(
          activeIcon,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: "",
    );
  }
}

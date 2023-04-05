import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('tr'),
    Locale('ur')
  ];

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an'**
  String get quran;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @surah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get surah;

  /// No description provided for @juz.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get juz;

  /// No description provided for @hizb.
  ///
  /// In en, this message translates to:
  /// **'Hizb'**
  String get hizb;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @sajda.
  ///
  /// In en, this message translates to:
  /// **'Sajda'**
  String get sajda;

  /// No description provided for @ayat.
  ///
  /// In en, this message translates to:
  /// **'Ayat'**
  String get ayat;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @helpGuide.
  ///
  /// In en, this message translates to:
  /// **'Help Guide'**
  String get helpGuide;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introduction;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @references.
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get references;

  /// No description provided for @switchTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch Theme'**
  String get switchTheme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @quranMode.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an Mode'**
  String get quranMode;

  /// No description provided for @greenMode.
  ///
  /// In en, this message translates to:
  /// **'Green Mode'**
  String get greenMode;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @selectedTranslation.
  ///
  /// In en, this message translates to:
  /// **'Selected Translations'**
  String get selectedTranslation;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @searchSurah.
  ///
  /// In en, this message translates to:
  /// **'Search Surah'**
  String get searchSurah;

  /// No description provided for @madeByFabrikod.
  ///
  /// In en, this message translates to:
  /// **'made by Huzaifa Saeed'**
  String get madeByFabrikod;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **' - V'**
  String get version;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @scroll.
  ///
  /// In en, this message translates to:
  /// **'Scroll'**
  String get scroll;

  /// No description provided for @mushaf.
  ///
  /// In en, this message translates to:
  /// **'Mushaf'**
  String get mushaf;

  /// No description provided for @quranType.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an Type'**
  String get quranType;

  /// No description provided for @readingStyle.
  ///
  /// In en, this message translates to:
  /// **'Reading Style'**
  String get readingStyle;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @fontType.
  ///
  /// In en, this message translates to:
  /// **'Font Type'**
  String get fontType;

  /// No description provided for @helpGuideTitle1.
  ///
  /// In en, this message translates to:
  /// **'What is Qur\'an Kareem'**
  String get helpGuideTitle1;

  /// No description provided for @helpGuideDescription1.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran is the religious text of Islam, believed by Muslims to be the word of God as revealed to Prophet Muhammad through the angel Gabriel. It contains guidance and teachings on various aspects of life, including faith, morality, spirituality, and daily living.'**
  String get helpGuideDescription1;

  /// No description provided for @helpGuideTitle2.
  ///
  /// In en, this message translates to:
  /// **'How many chapters does the Qur’an Kareem include?'**
  String get helpGuideTitle2;

  /// No description provided for @helpGuideDescription2.
  ///
  /// In en, this message translates to:
  /// **'114 chapters'**
  String get helpGuideDescription2;

  /// No description provided for @helpGuideTitle3.
  ///
  /// In en, this message translates to:
  /// **'Can I read separately versicles and chapters?'**
  String get helpGuideTitle3;

  /// No description provided for @helpGuideDescription3.
  ///
  /// In en, this message translates to:
  /// **'Yes you can. You can jump from one page to another in the way you prefer. You can also mark them so you can directly read them without searching them in the whole book.'**
  String get helpGuideDescription3;

  /// No description provided for @helpGuideTitle4.
  ///
  /// In en, this message translates to:
  /// **'Can I share the content in other places?'**
  String get helpGuideTitle4;

  /// No description provided for @helpGuideDescription4.
  ///
  /// In en, this message translates to:
  /// **'Yes you can, This is an open source app where you are free to use the content.'**
  String get helpGuideDescription4;

  /// No description provided for @helpGuideTitle5.
  ///
  /// In en, this message translates to:
  /// **'What is the purpose of the app?'**
  String get helpGuideTitle5;

  /// No description provided for @helpGuideDescription5.
  ///
  /// In en, this message translates to:
  /// **'The main purpose of the app is to offer to the community a native mobile app where they can read, listen and save their surahs, ayas or juzs.'**
  String get helpGuideDescription5;

  /// No description provided for @helpGuideTitle6.
  ///
  /// In en, this message translates to:
  /// **'What are the key features of the app?'**
  String get helpGuideTitle6;

  /// No description provided for @helpGuideDescription6.
  ///
  /// In en, this message translates to:
  /// **'You can read with no limit the Holy Qur’an, you mark with the bookmarks the last aya you read so you won’t get lost next time you open your Qur’an. You can listen the ayas in case you don’t know how to read it in Arabic and also you can save your most read surahs, ayas or juzs.'**
  String get helpGuideDescription6;

  /// No description provided for @helpGuideTitle7.
  ///
  /// In en, this message translates to:
  /// **'How can users troubleshoot problems and find solutions? '**
  String get helpGuideTitle7;

  /// No description provided for @helpGuideDescription7.
  ///
  /// In en, this message translates to:
  /// **'You can always contact us via email: huzaifasaeed00@gmail.com'**
  String get helpGuideDescription7;

  /// No description provided for @helpGuideTitle8.
  ///
  /// In en, this message translates to:
  /// **'Are there any known limitations or restrictions in the app?'**
  String get helpGuideTitle8;

  /// No description provided for @helpGuideDescription8.
  ///
  /// In en, this message translates to:
  /// **'No there is not, you can read and listen as much as you want.'**
  String get helpGuideDescription8;

  /// No description provided for @helpGuideTitle9.
  ///
  /// In en, this message translates to:
  /// **'Who is the target audience for the app?'**
  String get helpGuideTitle9;

  /// No description provided for @helpGuideDescription9.
  ///
  /// In en, this message translates to:
  /// **'Everyone who has an interest in getting to know the Holy Qur’an, reading or listen to it. Everyone is welcome.'**
  String get helpGuideDescription9;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next Page'**
  String get nextPage;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @previousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous Page'**
  String get previousPage;

  /// No description provided for @surahs.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahs;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found\nTry searching for a different keyword'**
  String get noResultsFound;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @noBookMarksAdded.
  ///
  /// In en, this message translates to:
  /// **'No Bookmarks Added'**
  String get noBookMarksAdded;

  /// No description provided for @noFavoritesAdded.
  ///
  /// In en, this message translates to:
  /// **'No Favorites Added'**
  String get noFavoritesAdded;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get and;

  /// No description provided for @theOpenQuran.
  ///
  /// In en, this message translates to:
  /// **'Al-Quran'**
  String get theOpenQuran;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @layout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layout;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get backgroundColor;

  /// No description provided for @ayatAndTranslation.
  ///
  /// In en, this message translates to:
  /// **'Ayat + Translation'**
  String get ayatAndTranslation;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @writeAnAppStoreReview.
  ///
  /// In en, this message translates to:
  /// **'Write an app store review'**
  String get writeAnAppStoreReview;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @meaning.
  ///
  /// In en, this message translates to:
  /// **'Meaning'**
  String get meaning;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigations'**
  String get navigation;

  /// No description provided for @searchSurahJuzOrAyahs.
  ///
  /// In en, this message translates to:
  /// **'Search surah, juz or ayahs...'**
  String get searchSurahJuzOrAyahs;

  /// No description provided for @searchSurahJuzOrPage.
  ///
  /// In en, this message translates to:
  /// **'Search for surah, juz or page...'**
  String get searchSurahJuzOrPage;

  /// No description provided for @searchFor.
  ///
  /// In en, this message translates to:
  /// **'Search for'**
  String get searchFor;

  /// No description provided for @reciter.
  ///
  /// In en, this message translates to:
  /// **'Reciter'**
  String get reciter;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @downloaded.
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get downloaded;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @quranFont.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an Font'**
  String get quranFont;

  /// No description provided for @availableToDownload.
  ///
  /// In en, this message translates to:
  /// **'Available to Download'**
  String get availableToDownload;

  /// No description provided for @fabrikodTwoThree.
  ///
  /// In en, this message translates to:
  /// **'@2025 Huzaifa Saeed'**
  String get fabrikodTwoThree;

  /// No description provided for @referencesDescription.
  ///
  /// In en, this message translates to:
  /// **'The goal of the project is to provide people with a convenient platform for studying the Holy Qur\'an. Therefore, the Qur\'an can now be read on smartphones, tablets and other modern devices.'**
  String get referencesDescription;

  /// No description provided for @referencesDescription2.
  ///
  /// In en, this message translates to:
  /// **' As explained in our Privacy Policy we do not collect any personal information.'**
  String get referencesDescription2;

  /// No description provided for @referencesDescription3.
  ///
  /// In en, this message translates to:
  /// **'The API and all Qur\'an sources are used from '**
  String get referencesDescription3;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us at huzaifasaeed00@gmail.com for assistance.'**
  String get contactUs;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @nextSurah.
  ///
  /// In en, this message translates to:
  /// **'Next Surah'**
  String get nextSurah;

  /// No description provided for @previousSurah.
  ///
  /// In en, this message translates to:
  /// **'Previous Surah'**
  String get previousSurah;

  /// No description provided for @beggingOfSurah.
  ///
  /// In en, this message translates to:
  /// **'Begging Of Surah'**
  String get beggingOfSurah;

  /// No description provided for @openSourceDevelopedByFabrikod.
  ///
  /// In en, this message translates to:
  /// **'open source developed by Huzaifa Saeed'**
  String get openSourceDevelopedByFabrikod;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'tr', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

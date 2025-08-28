import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:the_open_quran/utils/locale_utils.dart';

import '../constants/enums.dart';
import '../database/local_db.dart';
import '../managers/translation_download_manager.dart';
import '../models/translation.dart';
import 'asset_quran_service.dart';
import 'network_service.dart';

class TranslationService {
  /// Class constructor
  TranslationService() {
    _init();
  }

  /// List of all translation Country
  late List<TranslationCountry> allTranslationCountry;

  /// Initialization method
  /// Filling lists of translations
  Future _init() async {
    allTranslationCountry = await AssetQuranService.getTranslations();
    await _getVerseTranslationListFromAsset("en", 131);
    await _getVerseTranslationListFromAsset("ur", 54);
    // await _getVerseTranslationListFromAsset("tr", 77);

    final box = GetStorage('Al-Quran');
    final isFirstRun = box.read("isFirstRunTranslation") ?? true;

    if (isFirstRun) 
    {
      String localCountryCode =
          LocalDb.getLocale?.countryCode ?? Platform.localeName.split("_").first;
      bool isPakistani = await LocaleUtils.isUserFromPakistanIndia();
      if (localCountryCode == "ur" || isPakistani) {
        var author = _getTranslationAuthor(54);
        if (author != null) author.isTranslationSelected = true;
      } else {
        var author = _getTranslationAuthor(131);
        if (author != null) author.isTranslationSelected = true;
      }
      await saveSelectedAuthors(); // save default selection
      await box.write("isFirstRunTranslation", false);
    } else {
      // restore selected authors
      List<dynamic>? savedAuthors = box.read("selectedAuthors");
      if (savedAuthors != null) {
        for (var id in savedAuthors) {
          var author = _getTranslationAuthor(id);
          if (author != null) author.isTranslationSelected = true;
        }
      }
    }

    // restore downloaded translations
    var authors = await TranslationDownloadManager.getTranslationAuthors();
    for (var element in authors) {
      TranslationAuthor? author = _getTranslationAuthor(element.resourceId);
      if (author != null) {
        author.isTranslationSelected = element.isTranslationSelected;
        author.verseTranslations = element.verseTranslations;
        author.verseTranslationState = EVerseTranslationState.downloaded;
      }
    }
  }

  /// save selected authors in GetStorage
  Future<void> saveSelectedAuthors() async {
    final box = GetStorage('Al-Quran');
    final ids = selectedTranslationAuthors.map((e) => e.resourceId).toList();
    await box.write("selectedAuthors", ids);
  }

  /// List of selected translations in downloaded list
  List<TranslationAuthor> get selectedTranslationAuthors {
    List<TranslationAuthor> list = [];
    for (var element in allTranslationCountry) {
      for (var element in element.downloadedList) {
        if (element.isTranslationSelected) list.add(element);
      }
    }
    return list;
  }

  /// Get specific verse translation
  List<VerseTranslation> translationsOfVerse(int verseId) {
    List<VerseTranslation> list = [];
    for (var translationCountry in allTranslationCountry) {
      for (var translationsAuthor in translationCountry.downloadedList) {
        if (translationsAuthor.isTranslationSelected) {
          list.add(translationsAuthor.verseTranslations[verseId - 1]);
        }
      }
    }
    return list;
  }

  /// Get all verse translations
  String? get translationButtonName {
    var list = selectedTranslationAuthors;
    if (list.isEmpty) {
      return null;
    }
    if (list.length == 1) {
      return "${list.first.translationName}";
    }
    return "${list.first.translationName} +${list.length}";
  }

  /// Get verse translation names
  String translationsName(int resourceId) {
    var value = selectedTranslationAuthors
        .firstWhere((element) => element.resourceId == resourceId);
    return value.translationName ?? "";
  }

  /// Get translations from assets
  Future _getVerseTranslationListFromAsset(
      String countryCode, int resourceId) async {
    List<VerseTranslation> verseTranslations =
        await AssetQuranService.getVerseTranslationList(countryCode);
    TranslationAuthor? translationAuthor = _getTranslationAuthor(resourceId);
    if (translationAuthor == null) return;
    translationAuthor.verseTranslations = verseTranslations;
    translationAuthor.verseTranslationState = EVerseTranslationState.downloaded;

    for (var element in translationAuthor.verseTranslations) {
      element.translationName = translationAuthor.translationName;
    }
  }

  /// Get translation author name
  TranslationAuthor? _getTranslationAuthor(int? resourceId) {
    if (resourceId == null) return null;
    for (var element in allTranslationCountry) {
      for (var element in element.translationsAuthor) {
        if (element.resourceId == resourceId) return element;
      }
    }
    return null;
  }

  /// Downloading translations from Quran.com API V4
  Future<bool> downloadTranslationFromNetwork(
      TranslationAuthor translationAuthor) async {
    try {
      translationAuthor.verseTranslations =
          await NetworkService.fetchVerseTranslationList(
              translationAuthor.resourceId!);

      for (var element in translationAuthor.verseTranslations) {
        element.translationName = translationAuthor.translationName;
      }

      if (translationAuthor.verseTranslations.isEmpty) return false;
      await TranslationDownloadManager.setTranslationAuthor(translationAuthor);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete a Downloaded Translation
  Future<void> deleteTranslationAuthor(
      TranslationAuthor translationAuthor) async {
    if (selectedTranslationAuthors.length < 2 &&
        translationAuthor.isTranslationSelected) {
      return;
    }
    translationAuthor.isTranslationSelected = false;
    translationAuthor.verseTranslationState = EVerseTranslationState.download;
    translationAuthor.verseTranslations = [];
    await TranslationDownloadManager.deleteTranslationAuthor(translationAuthor);
  }
}

import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/models/bookmark_model.dart';
import 'package:fabrikod_quran/models/local_setting_model.dart';
import 'package:fabrikod_quran/models/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocalDb {
  LocalDb._();

  static final GetStorage _localDbBox = GetStorage('FabrikodQuran');

  /// Get locale from local database
  static Locale? get getLocale {
    String? code = _localDbBox.read('languageCode');
    if (code == null) return null;
    return Locale(code);
  }

  /// Change locale from local database
  static Future<Locale?> setLocale(String languageCode) async {
    await _localDbBox.write('languageCode', languageCode);
    return getLocale;
  }

  /// Get theme mode from local database
  static EThemeModes get getThemeMode {
    int? value = _localDbBox.read('themeMode');
    if (value == null) return EThemeModes.light;
    return EThemeModes.values[value];
  }

  /// Change theme mode from local database
  static Future<EThemeModes> setThemeMode(EThemeModes appThemeMode) async {
    await _localDbBox.write('themeMode', appThemeMode.index);
    return getThemeMode;
  }

  /// Get favorite verses
  static List<VerseModel> get getFavoriteVerses {
    var favoriteList = (_localDbBox.read('favoriteVerses') as List?) ?? [];
    return favoriteList.map((e) => VerseModel.fromJson(e)).toList().cast<VerseModel>();
  }

  /// Add verse model into favorite list and save to db
  static Future<List<VerseModel>> addVerseToFavorites(VerseModel verseModel) async {
    var favoriteList = getFavoriteVerses;
    favoriteList.add(verseModel);
    var value = favoriteList.map((e) => e.toJson()).toList();
    await _localDbBox.write('favoriteVerses', value);
    return getFavoriteVerses;
  }

  /// Delete verse model from the favorite list in db
  static Future<List<VerseModel>> deleteVerseFromTheFavorites(VerseModel verseModel) async {
    var favoriteList = getFavoriteVerses;
    favoriteList.removeWhere((element) => element.id == verseModel.id);
    var value = favoriteList.map((e) => e.toJson()).toList();
    await _localDbBox.write('favoriteVerses', value);
    return getFavoriteVerses;
  }

  /// Get bookmarks from db
  static List<BookMarkModel> get getBookmarks {
    var bookmarkList = (_localDbBox.read('bookmarks') as List?) ?? [];
    return bookmarkList.map((e) => BookMarkModel.fromJson(e)).toList().cast<BookMarkModel>();
  }

  /// Add bookmark in db
  static Future<List<BookMarkModel>> addBookmarked(BookMarkModel bookMark) async {
    var bookmarkList = getBookmarks;
    bookmarkList.add(bookMark);
    var value = bookmarkList.map((e) => e.toJson()).toList();
    await _localDbBox.write('bookmarks', value);
    return getBookmarks;
  }

  /// Delete bookmark from db
  static Future<List<BookMarkModel>> deleteBookmarked(BookMarkModel bookMark) async {
    var bookmarkList = getBookmarks;
    bookmarkList.removeWhere((element) => element == bookMark);
    var value = bookmarkList.map((e) => e.toJson()).toList();
    await _localDbBox.write('bookmarks', value);
    return getBookmarks;
  }

  /// Getting Local Settings Of Quran from Db
  static LocalSettingModel get getLocalSettingOfQuran {
    var result = _localDbBox.read('localSettingOfQuran');
    if (result == null) return LocalSettingModel();
    return LocalSettingModel.fromJson(result);
  }

  /// Adding Local Settings Of Quran to Db
  static Future<LocalSettingModel> setLocalSettingOfQuran(LocalSettingModel localSetting) async {
    await _localDbBox.write('localSettingOfQuran', localSetting.toJson());
    return getLocalSettingOfQuran;
  }
}
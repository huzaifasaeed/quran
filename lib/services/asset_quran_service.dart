import 'dart:convert';

import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/models/surah_model.dart';
import 'package:fabrikod_quran/models/translation.dart';
import 'package:flutter/services.dart';

class AssetQuranService {
  AssetQuranService._();

  /// Get all surahs and verses from assets
  static Future<List<SurahModel>> getAllOfSurahs() async {
    String data = await rootBundle.loadString(JsonPathConstants.quran);
    var result = json.decode(data) as List;
    return result.map((e) => SurahModel.fromJson(e)).toList().cast<SurahModel>();
  }

  static Future<List<VerseTranslation>> getVerseTranslationList(String languageCode) async {
    String data = await rootBundle.loadString(JsonPathConstants.verseTranslations(languageCode));
    var result = json.decode(data)["translations"];
    return result.map((e) => VerseTranslation.fromJson(e)).toList().cast<VerseTranslation>();
  }

  static Future<List<Translation>> getTranslations() async {
    String data = await rootBundle.loadString(JsonPathConstants.translations);
    var result = json.decode(data);
    return result.map((e) => Translation.fromJson(e)).toList().cast<Translation>();
  }
}
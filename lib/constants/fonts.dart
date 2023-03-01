import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

/// App Fonts
class Fonts {
  Fonts._();

  static final String nunitoW900 = GoogleFonts.nunito(fontWeight: FontWeight.w900).fontFamily!;

  /// For Verse Signs
  static const String uthmanic = "Uthmani";

  /// Translation Fonts
  static final String robotoSlab = GoogleFonts.robotoSlab().fontFamily!;
  static final String nunito = GoogleFonts.nunito().fontFamily!;

  /// Arabic Fonts
  static final String amiri = GoogleFonts.amiri().fontFamily ?? uthmanic;
  static final String lateef = GoogleFonts.lateef().fontFamily ?? uthmanic;
  static final String notoNaskhArabic = GoogleFonts.notoNaskhArabic().fontFamily ?? uthmanic;

  static const List<String> translationFontNames = ["Nunito", "Roboto Slab"];
  static const List<String> arabicFontNames = ["Uthmani","Nunito", "Amiri", "Lateef", "Noto Naskh"];

  static String? getTranslationFont(String fontName) {
    if (fontName == translationFontNames[1]) return robotoSlab;
    return nunito;
  }

  static String? getArabicFont(String fontName) {
    if (fontName == arabicFontNames[1]) return nunito;
    if (fontName == arabicFontNames[2]) return amiri;
    if (fontName == arabicFontNames[3]) return lateef;
    if (fontName == arabicFontNames[4]) return notoNaskhArabic;
    return uthmanic;
  }
}

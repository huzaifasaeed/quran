import 'package:flutter/material.dart';

import '../services/network_service.dart';

class LocaleUtils {
  /// Detects if the user is from Pakistan based on their IP address
  static Future<bool> isUserFromPakistan() async {
    final countryCode = await NetworkService.getCountryCodeFromIP();
    return countryCode?.toUpperCase() == 'PK';
  }

  /// Gets the default Arabic font based on user location
  static Future<String> getDefaultArabicFontForLocale() async {
    if (await isUserFromPakistan()) {
      return "IndoPak";
    }
    return "Uthmani"; // Default font for other users
  }
}

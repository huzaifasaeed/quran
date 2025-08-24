import 'dart:convert';
import 'package:country_ip/country_ip.dart';
import 'package:http/http.dart' as http;
import '../constants/restful.dart';
import '../models/translation.dart';

class NetworkService {
  static Future<List<VerseTranslation>> fetchVerseTranslationList(
      int resourceId) async {
    String url = RestfulConstants.verseTranslation(resourceId);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["translations"]
          .map((e) => VerseTranslation.fromJson(e))
          .toList()
          .cast<VerseTranslation>();
    } else {
      return [];
    }
  }
  /// Fetches the user's country code from an IP-based geolocation service.
  /// Returns the country code (e.g., 'PK') on success, or null on failure.
  static Future<String?> getCountryCodeFromIP() async {
    try {
      final response = await CountryIp.find();
      return response!.countryCode;
    } catch (e) {
      // Handle exceptions like no internet connection, etc.
      print('Error fetching country code from IP: $e');
    }
    return null;
  }
}

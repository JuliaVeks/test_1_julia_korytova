
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://api.freecurrencyapi.com/v6/latest';

  static Future<Map<String, dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  static Future<Map<String, dynamic>> fetchCustomExchangeRates(String currencyPair) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$currencyPair'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load custom exchange rates');
    }
  }
}

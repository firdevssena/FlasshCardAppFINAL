// Gerekli dart paketlerini içe aktarma
import 'dart:convert';
import 'package:http/http.dart' as http;

// Logo URL'sini API'den çeken fonksiyon
Future<String> fetchLogoUrl() async {
  final response = await http.get(Uri.parse('https://api.example.com/logo'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['logoUrl'];
  } else {
    throw Exception('Logo yüklenemedi');
  }
}
// Gerekli Flutter paketlerini içe aktarma
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Resim yükleme işlemlerini yöneten provider sınıfı
class ResimSaglayici extends ChangeNotifier {
  // Resim URL'si ve yükleme durumu için değişkenler
  String? imageURL;
  bool yukleniyor = false;

  // Logo resmini yükleyen fonksiyon
  Future<void> fetchLogo() async {
    yukleniyor = true;
    notifyListeners();
    try {
      final uri = Uri.parse('https://play-lh.googleusercontent.com/CQMo1yrgFRoYXc6_DN-SAwW2fjQI9tlTQj1PO1lakl6UvJJkENUGfUy-DMQE1FR9yui8');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        imageURL = uri.toString();
      } else {
        throw Exception('Logo yüklenemedi');
      }
    } catch (e) {
      print("Hata: $e");
      imageURL = null;
    } finally {
      yukleniyor = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';

// Logo durumunu yöneten provider sınıfı
class LogoProvider extends ChangeNotifier {
  // Logo URL'sini ve yükleme durumunu tutan değişkenler
  String? _logoUrl;
  bool _isLoading = true;

  // Logo URL'si ve yükleme durumu için getter'lar
  String? get logoUrl => _logoUrl;
  bool get isLoading => _isLoading;

  // Logo URL'sini güncelleyen fonksiyon
  void setLogoUrl(String url) {
    _logoUrl = url;
    _isLoading = true;  
    notifyListeners();
  }

  // Yükleme durumunu güncelleyen fonksiyon
  void finishLoading() {
    _isLoading = false;
    notifyListeners();
  }
}

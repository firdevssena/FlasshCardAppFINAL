// Gerekli Flutter widget'larını içe aktarma
import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // Import CustomAppBar
import 'drawer_widget.dart'; // Import AppDrawer

// Temel sayfa yapısını oluşturan widget
class BasePage extends StatelessWidget {
  // Sayfa başlığı, içeriği ve ek butonlar için değişkenler
  final String title;
  final Widget body;
  final List<Widget>? actions;

  // Constructor
  const BasePage({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  // Widget ağacını oluşturan build metodu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Drawer'ı açmak için
              },
            );
          },
        ),
        actions: actions,
      ),
      drawer: AppDrawer(),
      body: body,
    );
  }
} 
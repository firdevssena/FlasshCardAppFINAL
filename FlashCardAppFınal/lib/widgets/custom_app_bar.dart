// Gerekli Flutter widget'ını içe aktarma
import 'package:flutter/material.dart';

// Özelleştirilmiş AppBar widget'ı
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // AppBar özellikleri için değişkenler
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  // Constructor
  const CustomAppBar({super.key, required this.title, this.leading, this.actions});

  // Widget ağacını oluşturan build metodu
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      actions: actions,
      // You can customize the appearance here
    );
  }

  // AppBar yüksekliğini belirleyen getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 
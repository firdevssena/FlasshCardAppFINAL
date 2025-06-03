import 'package:flutter/material.dart';
import 'package:flashcard_app/widgets/drawer_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/base_page.dart';

// Ayarlar sayfası widget'ı
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

// Ayarlar sayfası widget'ının durum sınıfı
class _SettingsPageState extends State<SettingsPage> {
  // Bildirim durumunu tutan değişken
  bool _notificationsEnabled = true;

  // Bildirim durumunu değiştiren fonksiyon
  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Ayarlar',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bildirim Ayarları',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Bildirimler Kapalı'),
                const Spacer(),
                Switch(
                  value: _notificationsEnabled, 
                  onChanged: _toggleNotifications, 
                ),
                const Text('Bildirimler Açık'),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

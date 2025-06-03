import 'package:flutter/material.dart';
import 'package:flashcard_app/widgets/logo_widget.dart';
import '../services/auth.dart'; // Import Auth service
import 'package:provider/provider.dart'; // Import Provider
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

// Yan menü widget'ı
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider ile kimlik doğrulama servisine erişim
    return Builder(
      builder: (BuildContext drawerContext) {
        final authService = Provider.of<Auth>(drawerContext, listen: false);

        // Yan menü yapısını oluşturma
        return Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 239, 180, 180), 
                  Color.fromARGB(255, 152, 169, 222), 
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              children: <Widget>[
                const DrawerHeader(
                  child: LogoWidget(), 
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 253, 219, 219),
                  ),
                ),
                _buildDrawerItem(
                  drawerContext, 
                  'Ana Sayfa', 
                  Icons.home, 
                  '/home'
                ),
                _buildDrawerItem(
                  drawerContext, 
                  'Çeviri', 
                  Icons.translate, 
                  '/translate' 
                ),
                _buildDrawerItem(
                  drawerContext, 
                  'Ayarlar', 
                  Icons.settings, 
                  '/settings'
                ),
                const Divider(
                  color: Colors.white70, 
                  thickness: 0.8,
                ),
                _buildDrawerItem(
                  drawerContext, 
                  'Çıkış Yap', 
                  Icons.exit_to_app, 
                  '/',
                  onTap: () async { // Added onTap function
                    await authService.signOut(); // Sign out from Firebase
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear(); // Clear shared preferences
                    Navigator.of(drawerContext).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false); // Use drawerContext for navigation
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, String route, {VoidCallback? onTap}) { // Added optional onTap parameter
    return InkWell(
      onTap: onTap ?? () { // Use provided onTap or default navigation
        Navigator.pushNamed(context, route);
      },
      splashColor: Colors.white30, 
      highlightColor: Colors.white24, 
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 11, 5, 48),
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 11, 5, 48),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

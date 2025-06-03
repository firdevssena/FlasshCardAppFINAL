import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/settings_page.dart';
import 'pages/translation_page.dart'; 
import 'services/logo_provider.dart'; 
import 'services/resim_saglayici.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth.dart';

// Ana fonksiyon - uygulama başlangıç noktası
void main() async { 
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  // Yönlendirme sonuçlarını kontrol etme
  await FirebaseAuth.instance.getRedirectResult();

  // Provider'ları ayarlama ve uygulamayı başlatma
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => LogoProvider()
            ..setLogoUrl('https://play-lh.googleusercontent.com/CQMo1yrgFRoYXc6_DN-SAwW2fjQI9tlTQj1PO1lakl6UvJJkENUGfUy-DMQE1FR9yui8'),
        ),
        ChangeNotifierProvider(
          create: (_) => ResimSaglayici()..fetchLogo(),
        ),
      ],
      child: const FlashcardApp(),
    ),
  );
}

// Ana uygulama widget'ı
class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      // Use a FutureBuilder to check auth state and navigate accordingly
      home: FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser), // Or check getRedirectResult() here as well
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ); // Show loading indicator
          }
          if (snapshot.hasData) {
            return const HomePage(); // User is logged in
          } else {
            return const LoginPage(); // User is not logged in
          }
        },
      ),
      routes: {
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
        '/translate': (context) => const TranslationPage(), 
      },
    );
  }
}

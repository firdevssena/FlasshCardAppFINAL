import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_app/services/resim_saglayici.dart';  
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication hatalarını yakalamak için ekledik
import '../widgets/custom_app_bar.dart';

// Giriş sayfası widget'ı
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Giriş sayfası widget'ının durum sınıfı
class _LoginPageState extends State<LoginPage> {
  // Text kontrolcüleri - kullanıcı girişlerini yönetmek için
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Auth _auth = Auth();

  // Giriş yapma fonksiyonu
  void _login() async {
    try {
      await _auth.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // If login is successful, navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Bu e-posta adresine kayıtlı kullanıcı bulunamadı.';
      } else if (e.code == 'wrong-password') {
        message = 'Yanlış şifre.';
      } else {
        message = 'Giriş hatası: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // Handle other potential errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bir hata oluştu: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resimSaglayici = Provider.of<ResimSaglayici>(context);

    return Scaffold(
      appBar: CustomAppBar(title: "Flashcard App"),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 182, 193), // Yumuşak pembe tonu
              Color.fromARGB(255, 173, 216, 230), // Açık mavi tonları
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24.0), // Padding artırıldı
            children: [
              // Logo ve Başlık Ortalandı
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     if (resimSaglayici.yukleniyor)
                      const CircularProgressIndicator(color: Colors.white),
                    if (!resimSaglayici.yukleniyor && resimSaglayici.imageURL != null)
                      Image.network(
                        resimSaglayici.imageURL!,
                        height: 150,
                      ),
                    const SizedBox(height: 20),
                    const Text(
                      'Flashcard App',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87), // Yazı boyutu ve rengi
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50), // Boşluk artırıldı

              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-posta",
                  prefixIcon: Icon(Icons.email, color: Colors.blueGrey[700]), // İkon rengi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                    borderSide: BorderSide.none, // Kenarlık yok
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Hafif saydam dolgu
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20), // Boşluk eklendi

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: Icon(Icons.lock, color: Colors.blueGrey[700]), // İkon rengi
                   border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                    borderSide: BorderSide.none, // Kenarlık yok
                  ),
                   filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Hafif saydam dolgu
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
                ),
              ),
              const SizedBox(height: 30), // Boşluk artırıldı

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[800], // Buton rengi
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                  ),
                  elevation: 5, // Gölge ekleme
                ),
                child: const Text(
                  "Giriş Yap",
                  style: TextStyle(fontSize: 18, color: Colors.white), // Yazı rengi
                ),
              ),
              const SizedBox(height: 20), // Boşluk eklendi

              // Google ile Giriş Butonu
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithGoogle();
                     // If login is successful, navigate to home page
                    Navigator.pushReplacementNamed(context, '/home');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google ile giriş hatası: ${e.toString()}")),
                    );
                  }
                },
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Google rengi
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 5,
                 ),
                child: const Text(
                  "Google ile Giriş Yap",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20), // Boşluk eklendi

               // GitHub ile Giriş Butonu
              ElevatedButton(
                onPressed: () async {
                   try {
                    await _auth.signInWithGitHub();
                     // If login is successful, navigate to home page
                    Navigator.pushReplacementNamed(context, '/home');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("GitHub ile giriş hatası: ${e.toString()}")),
                    );
                  }
                },
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87, // GitHub rengi
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 5,
                 ),
                child: const Text(
                  "GitHub ile Giriş Yap",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20), // Boşluk eklendi

              // Kayıt ol Linki
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Hesabınız yok mu? Kayıt olun",
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey[900]), // Yazı rengi
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

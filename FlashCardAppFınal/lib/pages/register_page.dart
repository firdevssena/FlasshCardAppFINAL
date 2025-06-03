import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication hatalarını yakalamak için ekledik
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore için eklendi
import '../widgets/custom_app_bar.dart';

// Kayıt sayfası widget'ı
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// Kayıt sayfası widget'ının durum sınıfı
class _RegisterPageState extends State<RegisterPage> {
  // Text kontrolcüleri - kullanıcı bilgilerini yönetmek için
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController(); // Doğum yeri için controller
  final TextEditingController _cityController = TextEditingController(); // Yaşadığı il için controller
  DateTime? _dateOfBirth; // Doğum tarihi için değişken
  
  // Firebase servisleri
  final Auth _auth = Auth();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance'ı

  // Doğum tarihi seçme fonksiyonu
  void _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final placeOfBirth = _placeOfBirthController.text.trim();
    final city = _cityController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && surname.isNotEmpty && placeOfBirth.isNotEmpty && city.isNotEmpty && _dateOfBirth != null) {
      try {
        UserCredential userCredential = await _auth.createUser(email: email, password: password);
        String uid = userCredential.user!.uid; // Kaydedilen kullanıcının UID'sini al

        // Kullanıcının ek bilgilerini Firestore'a kaydet
        await _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'name': name,
          'surname': surname,
          'dateOfBirth': _dateOfBirth, // DateTime olarak saklanabilir
          'placeOfBirth': placeOfBirth,
          'city': city,
          'createdAt': Timestamp.now(), // Kayıt tarihi
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Başarıyla kayıt oldunuz!")),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'Şifre çok zayıf.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Bu e-posta adresi zaten kullanımda.';
        } else if (e.code == 'invalid-email') {
          message = 'Geçersiz e-posta adresi.';
        } else {
          message = 'Kayıt hatası: ${e.message}';
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun ve doğum tarihinizi seçin.")),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _placeOfBirthController.dispose(); // Dispose eklendi
    _cityController.dispose(); // Dispose eklendi
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Kayıt Ol"),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 182, 193), 
              Color.fromARGB(255, 173, 216, 230), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24.0),
            children: [
             const Text(
              'Kayıt Ol',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87), // Yazı boyutu ve rengi
              textAlign: TextAlign.center, // Başlık ortalandı
            ),
            const SizedBox(height: 40), // Boşluk artırıldı

            // Ad TextField
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Ad",
                prefixIcon: Icon(Icons.person, color: Colors.blueGrey[700]), // İkon rengi
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                  borderSide: BorderSide.none, // Kenarlık yok
                ),
                 filled: true,
                fillColor: Colors.white.withOpacity(0.8), // Hafif saydam dolgu
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

            // Soyad TextField
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: "Soyad",
                prefixIcon: Icon(Icons.person_outline, color: Colors.blueGrey[700]), // İkon rengi
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                  borderSide: BorderSide.none, // Kenarlık yok
                ),
                 filled: true,
                fillColor: Colors.white.withOpacity(0.8), // Hafif saydam dolgu
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

            // E-posta TextField
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

            // Şifre TextField
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

            // Doğum Tarihi Seçici
            GestureDetector(
              onTap: () => _selectDateOfBirth(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: _dateOfBirth == null ? '' : '${_dateOfBirth!.toLocal()}'.split(' ')[0]), // Seçilen tarihi göster
                   decoration: InputDecoration(
                    labelText: "Doğum Tarihi",
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blueGrey[700]), // İkon
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                      borderSide: BorderSide.none, // Kenarlık yok
                    ),
                     filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Hafif saydam dolgu
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

            // Doğum Yeri TextField
            TextField(
              controller: _placeOfBirthController,
              decoration: InputDecoration(
                labelText: "Doğum Yeri",
                prefixIcon: Icon(Icons.location_city, color: Colors.blueGrey[700]), // İkon rengi
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                  borderSide: BorderSide.none, // Kenarlık yok
                ),
                 filled: true,
                fillColor: Colors.white.withOpacity(0.8), // Hafif saydam dolgu
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

             // Yaşadığı İl TextField
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Yaşadığı İl",
                prefixIcon: Icon(Icons.location_on, color: Colors.blueGrey[700]), // İkon rengi
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

            // Kayıt Ol Button
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[800], // Buton rengi
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Köşe yuvarlama
                ),
                 elevation: 5, // Gölge ekleme
                 minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Kayıt Ol",
                style: TextStyle(fontSize: 18, color: Colors.white), // Yazı rengi
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

            // Google ile Kayıt/Giriş Butonu
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.signInWithGoogle(); // Kayıt veya Giriş için Google metodu
                   // If sign-in is successful, navigate to home page
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Google ile kayıt/giriş hatası: ${e.toString()}")),
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
                "Google ile Kayıt Ol / Giriş Yap",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

             // GitHub ile Kayıt/Giriş Butonu
            ElevatedButton(
              onPressed: () async {
                 try {
                  await _auth.signInWithGitHub(); // Kayıt veya Giriş için GitHub metodu
                   // If sign-in is successful, navigate to home page
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("GitHub ile kayıt/giriş hatası: ${e.toString()}")),
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
                "GitHub ile Kayıt Ol / Giriş Yap",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20), // Boşluk eklendi

            // Giriş Yap Linki
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                "Zaten hesabınız var mı? Giriş yap",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey[900]), // Yazı rengi
              ),
            ),
          ],
        ),
      ),
    ));

  }
}

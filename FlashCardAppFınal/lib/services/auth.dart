import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_db_helper.dart'; // Import the UserDbHelper
import 'package:flutter/material.dart'; // Import Material for ChangeNotifier

// Kimlik doğrulama servisi sınıfı
class Auth extends ChangeNotifier {
  // Firebase ve Google servisleri için instance'lar
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: "639152247130-8c2erq01r7hnagmri4733u8a6n669vk8.apps.googleusercontent.com");

  // Mevcut kullanıcıyı ve kimlik doğrulama durumu değişikliklerini izleme
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  
  // Yeni kullanıcı kaydı oluşturma fonksiyonu
  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Kullanıcı girişi fonksiyonu
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _saveUserDataToSharedPreferences(userCredential.user!);
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Acquire the authentication details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      await _saveUserDataToSharedPreferences(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      // Handle firebase auth errors
      rethrow; // Yeniden fırlat ki çağıran yerde yakalanabilsin
    } catch (e) {
      // Handle other errors
      rethrow; // Yeniden fırlat ki çağıran yerde yakalanabilsin
    }
  }

  // Sign in with GitHub
  Future<void> signInWithGitHub() async {
    try {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();

      // Trigger the authentication flow using signInWithPopup for web compatibility
      UserCredential userCredential = await _firebaseAuth.signInWithPopup(githubProvider);
      await _saveUserDataToSharedPreferences(userCredential.user!);

    } on FirebaseAuthException catch (e) {
      // Handle firebase auth errors
       rethrow; // Yeniden fırlat ki çağıran yerde yakalanabilsin
    } catch (e) {
      // Handle other errors
       rethrow; // Yeniden fırlat ki çağıran yerde yakalanabilsin
    }
  }

  Future<void> _saveUserDataToSharedPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uid', user.uid);
    await prefs.setString('user_email', user.email ?? '');

    // Fetch user data from Firestore to get name and surname
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      await prefs.setString('user_name', userDoc['name'] ?? '');
      await prefs.setString('user_surname', userDoc['surname'] ?? '');

      // Save user data to SQLite after fetching from Firestore
      UserDbHelper dbHelper = UserDbHelper();
      await dbHelper.insertUser(user, userDoc.data() as Map<String, dynamic>);
    }
  }
} 
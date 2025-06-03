// FlutterFire CLI tarafından oluşturulan dosya.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase uygulamaları için varsayılan yapılandırma seçenekleri.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  /// Mevcut platform için uygun Firebase yapılandırmasını döndüren getter
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// Web platformu için Firebase yapılandırması
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDwhO0CLoFiZKQjfC_Jyk7ADCpm1cx87dU',
    appId: '1:639152247130:web:5bffb6d985512a7f00a363',
    messagingSenderId: '639152247130',
    projectId: 'flashcardapp-f2170',
    authDomain: 'flashcardapp-f2170.firebaseapp.com',
    storageBucket: 'flashcardapp-f2170.firebasestorage.app',
    measurementId: 'G-3Q72GTS5GF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsndLoR8lJH1zHaQPSezQwmkkNh1_lv18',
    appId: '1:639152247130:android:85eb95c450d7de5300a363',
    messagingSenderId: '639152247130',
    projectId: 'flashcardapp-f2170',
    storageBucket: 'flashcardapp-f2170.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWTqDFaF-mmp9laFEeDqVJhNGn_ew_Wx4',
    appId: '1:639152247130:ios:88bf6d6a99edd01d00a363',
    messagingSenderId: '639152247130',
    projectId: 'flashcardapp-f2170',
    storageBucket: 'flashcardapp-f2170.firebasestorage.app',
    iosBundleId: 'com.example.flashcardApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWTqDFaF-mmp9laFEeDqVJhNGn_ew_Wx4',
    appId: '1:639152247130:ios:88bf6d6a99edd01d00a363',
    messagingSenderId: '639152247130',
    projectId: 'flashcardapp-f2170',
    storageBucket: 'flashcardapp-f2170.firebasestorage.app',
    iosBundleId: 'com.example.flashcardApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDwhO0CLoFiZKQjfC_Jyk7ADCpm1cx87dU',
    appId: '1:639152247130:web:1979f50dbb16325200a363',
    messagingSenderId: '639152247130',
    projectId: 'flashcardapp-f2170',
    authDomain: 'flashcardapp-f2170.firebaseapp.com',
    storageBucket: 'flashcardapp-f2170.firebasestorage.app',
    measurementId: 'G-C579TW94B6',
  );
}

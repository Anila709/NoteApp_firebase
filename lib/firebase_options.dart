// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDAF1nKnI9jt3XSqE-HrSJxGcWOkQeN2BA',
    appId: '1:731969403032:web:59267c512bda18d123f8ed',
    messagingSenderId: '731969403032',
    projectId: 'myfirebase709',
    authDomain: 'myfirebase709.firebaseapp.com',
    storageBucket: 'myfirebase709.appspot.com',
    measurementId: 'G-0BFV1BEX84',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClKAkHuaR4fDKRaZWU0yM5IeOuzMU1fFA',
    appId: '1:731969403032:android:5600419e87b24e9223f8ed',
    messagingSenderId: '731969403032',
    projectId: 'myfirebase709',
    storageBucket: 'myfirebase709.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwE0uAvjW6d0YXKI_5GkpA1mKCa3Lw23Y',
    appId: '1:731969403032:ios:48d918b0d0b8639023f8ed',
    messagingSenderId: '731969403032',
    projectId: 'myfirebase709',
    storageBucket: 'myfirebase709.appspot.com',
    iosBundleId: 'com.example.myFirebase709',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwE0uAvjW6d0YXKI_5GkpA1mKCa3Lw23Y',
    appId: '1:731969403032:ios:d2f824fc579f633a23f8ed',
    messagingSenderId: '731969403032',
    projectId: 'myfirebase709',
    storageBucket: 'myfirebase709.appspot.com',
    iosBundleId: 'com.example.myFirebase709.RunnerTests',
  );
}

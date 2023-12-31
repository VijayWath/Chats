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
    apiKey: 'AIzaSyDv4ve-xM-Rr3q8_SMy2XUI7YkFE7e7DUg',
    appId: '1:1071849982590:web:b7e9767bfc93b4f96ce62f',
    messagingSenderId: '1071849982590',
    projectId: 'flutter-chat-app-10f34',
    authDomain: 'flutter-chat-app-10f34.firebaseapp.com',
    storageBucket: 'flutter-chat-app-10f34.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbUS0PjI10t8Y1ePhRlncUG4MmjvzWMRY',
    appId: '1:1071849982590:android:2748ec0adfc05cf06ce62f',
    messagingSenderId: '1071849982590',
    projectId: 'flutter-chat-app-10f34',
    storageBucket: 'flutter-chat-app-10f34.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5XbSYD42lCes03dtWbvfkkA9T9lmuzfk',
    appId: '1:1071849982590:ios:6620ac9247b7698e6ce62f',
    messagingSenderId: '1071849982590',
    projectId: 'flutter-chat-app-10f34',
    storageBucket: 'flutter-chat-app-10f34.appspot.com',
    iosClientId: '1071849982590-5a1a3ng2dfnc892ojrbaut9r63g3a3ue.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5XbSYD42lCes03dtWbvfkkA9T9lmuzfk',
    appId: '1:1071849982590:ios:c112a6711f301bf66ce62f',
    messagingSenderId: '1071849982590',
    projectId: 'flutter-chat-app-10f34',
    storageBucket: 'flutter-chat-app-10f34.appspot.com',
    iosClientId: '1071849982590-jn2u7u1r37a41vpb4t8i2ej8lrijgbuk.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}

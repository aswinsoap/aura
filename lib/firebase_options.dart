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
    apiKey: 'AIzaSyBcmS-gecxZseH5ZsCfamWyyBKlhU-g3AU',
    appId: '1:1087997266313:web:b57c5c06c93f36f87cf958',
    messagingSenderId: '1087997266313',
    projectId: 'aura-8266',
    authDomain: 'aura-8266.firebaseapp.com',
    databaseURL: 'https://aura-8266-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aura-8266.appspot.com',
    measurementId: 'G-ZSSQ413SGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUW-xntfJfxYbaEZ6Fa6kpgg7SI1vXERs',
    appId: '1:1087997266313:android:fd6d5e84396cb6937cf958',
    messagingSenderId: '1087997266313',
    projectId: 'aura-8266',
    databaseURL: 'https://aura-8266-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aura-8266.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDxxOXYGHlOkZiozHEUixa9nP-XGFeZDg',
    appId: '1:1087997266313:ios:bbefaf3d9219cdad7cf958',
    messagingSenderId: '1087997266313',
    projectId: 'aura-8266',
    databaseURL: 'https://aura-8266-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aura-8266.appspot.com',
    iosBundleId: 'com.example.aura',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDxxOXYGHlOkZiozHEUixa9nP-XGFeZDg',
    appId: '1:1087997266313:ios:fcb2712dfe102cc17cf958',
    messagingSenderId: '1087997266313',
    projectId: 'aura-8266',
    databaseURL: 'https://aura-8266-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aura-8266.appspot.com',
    iosBundleId: 'com.example.aura.RunnerTests',
  );
}

// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBDr3jIBxRbyEo4ALqitdLuQWOt6_JRbwY',
    appId: '1:574148835165:web:a15ecd1fbd003d163c1ab4',
    messagingSenderId: '574148835165',
    projectId: 'hommie-687ca',
    authDomain: 'hommie-687ca.firebaseapp.com',
    storageBucket: 'hommie-687ca.appspot.com',
    measurementId: 'G-SBY78P13BX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5Aen7PJ_zMsaFynEUMqJYcOzYyuTx5YE',
    appId: '1:574148835165:android:8e53d3f5fa8d9c6d3c1ab4',
    messagingSenderId: '574148835165',
    projectId: 'hommie-687ca',
    storageBucket: 'hommie-687ca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBA0xCauYcP7z8vJ48IKi-nn2p4jfjfhdo',
    appId: '1:574148835165:ios:33ac266ae09131e13c1ab4',
    messagingSenderId: '574148835165',
    projectId: 'hommie-687ca',
    storageBucket: 'hommie-687ca.appspot.com',
    iosBundleId: 'com.example.hommie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBA0xCauYcP7z8vJ48IKi-nn2p4jfjfhdo',
    appId: '1:574148835165:ios:33ac266ae09131e13c1ab4',
    messagingSenderId: '574148835165',
    projectId: 'hommie-687ca',
    storageBucket: 'hommie-687ca.appspot.com',
    iosBundleId: 'com.example.hommie',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBDr3jIBxRbyEo4ALqitdLuQWOt6_JRbwY',
    appId: '1:574148835165:web:6b4db338b05a653e3c1ab4',
    messagingSenderId: '574148835165',
    projectId: 'hommie-687ca',
    authDomain: 'hommie-687ca.firebaseapp.com',
    storageBucket: 'hommie-687ca.appspot.com',
    measurementId: 'G-M9LGEPQM2Q',
  );
}
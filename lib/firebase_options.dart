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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCz_uuANZRysj_o6j3uQVBt4yHvdakaFGc',
    appId: '1:607049339701:web:52553f4be5ca53efe4327c',
    messagingSenderId: '607049339701',
    projectId: 'jordan-szymczyk-portfolio',
    authDomain: 'jordan-szymczyk-portfolio.firebaseapp.com',
    storageBucket: 'jordan-szymczyk-portfolio.firebasestorage.app',
    measurementId: 'G-2H638GLSHF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZfTSXo2Ya3R_1T5NgRIcMd32-gYhWFuA',
    appId: '1:607049339701:android:f03e9f8355d91916e4327c',
    messagingSenderId: '607049339701',
    projectId: 'jordan-szymczyk-portfolio',
    storageBucket: 'jordan-szymczyk-portfolio.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRHCbGNfmd4Qjg02hbAencDiyAlC8oZVA',
    appId: '1:607049339701:ios:777e7f7d9245f517e4327c',
    messagingSenderId: '607049339701',
    projectId: 'jordan-szymczyk-portfolio',
    storageBucket: 'jordan-szymczyk-portfolio.firebasestorage.app',
    iosBundleId: 'com.example.portfolio',
  );

}
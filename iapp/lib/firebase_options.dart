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
    apiKey: 'AIzaSyAWuasXHXQkQoxmTNtsz37rOqTneJOAuzg',
    appId: '1:100252276555:web:6bbec9b5e1faabc3927ace',
    messagingSenderId: '100252276555',
    projectId: 'aesthetica-project',
    authDomain: 'aesthetica-project.firebaseapp.com',
    storageBucket: 'aesthetica-project.appspot.com',
    measurementId: 'G-HPXLVBY55K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSG6V4QxFP6n0GqNTae-02aib6Yg_G3GI',
    appId: '1:100252276555:android:7e022eaae9489d70927ace',
    messagingSenderId: '100252276555',
    projectId: 'aesthetica-project',
    storageBucket: 'aesthetica-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfuFEZm_LHcdV8-hi_3YFbewgHv5TxyTc',
    appId: '1:100252276555:ios:0ac2fab4e2421010927ace',
    messagingSenderId: '100252276555',
    projectId: 'aesthetica-project',
    storageBucket: 'aesthetica-project.appspot.com',
    androidClientId: '100252276555-ppdd4bokft0scbgm1mb8rqkr1ljor0bh.apps.googleusercontent.com',
    iosClientId: '100252276555-c6rkpvruarh03qhsh00va3rsb888ddpa.apps.googleusercontent.com',
    iosBundleId: 'com.example.aesthetica.afvv2602',
  );
}
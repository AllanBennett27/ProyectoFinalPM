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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBv0gPKq31VIkoWqLC9l7w6NPlPrXhfW4g',
    appId: '1:620923779952:web:2671ccb1561065bad3edb5',
    messagingSenderId: '620923779952',
    projectId: 'app-sweetclick',
    authDomain: 'app-sweetclick.firebaseapp.com',
    storageBucket: 'app-sweetclick.firebasestorage.app',
    measurementId: 'G-510KRK8MM6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDdvUZyrWdhpHT8RzKurJWsoCFydVVfnE',
    appId: '1:620923779952:android:828ea2bf0566cd61d3edb5',
    messagingSenderId: '620923779952',
    projectId: 'app-sweetclick',
    storageBucket: 'app-sweetclick.firebasestorage.app',
  );
}

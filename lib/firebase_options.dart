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
    apiKey: 'AIzaSyCnccs_vrK4lSntnJKz56Y4YzBI08Mv1eE',
    appId: '1:501964416376:web:7f9a8040b48ee35d4b948d',
    messagingSenderId: '501964416376',
    projectId: 'petsapp-80636',
    authDomain: 'petsapp-80636.firebaseapp.com',
    storageBucket: 'petsapp-80636.appspot.com',
    measurementId: 'G-Q7LSGKYMX3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJyzqwVj4jTbgPi0yo_LNtUOj1GK-s7zQ',
    appId: '1:501964416376:android:c552c7d936c502524b948d',
    messagingSenderId: '501964416376',
    projectId: 'petsapp-80636',
    storageBucket: 'petsapp-80636.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlrKZ_EyegKSZtgnb9ym1_njb96vicpDQ',
    appId: '1:501964416376:ios:cd5e6f46e250087c4b948d',
    messagingSenderId: '501964416376',
    projectId: 'petsapp-80636',
    storageBucket: 'petsapp-80636.appspot.com',
    iosBundleId: 'com.example.flutterApplicationPetsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlrKZ_EyegKSZtgnb9ym1_njb96vicpDQ',
    appId: '1:501964416376:ios:12822c582dbbbde24b948d',
    messagingSenderId: '501964416376',
    projectId: 'petsapp-80636',
    storageBucket: 'petsapp-80636.appspot.com',
    iosBundleId: 'com.example.flutterApplicationPetsapp.RunnerTests',
  );
}

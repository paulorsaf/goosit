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
    apiKey: 'AIzaSyCoBSu7rbsJ7SdHiE35mXyWPEEbP2XHh5k',
    appId: '1:867190690730:web:b6b28c3f437d2f945291d3',
    messagingSenderId: '867190690730',
    projectId: 'goosit-8c0fb',
    authDomain: 'goosit-8c0fb.firebaseapp.com',
    storageBucket: 'goosit-8c0fb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEWdZywH9tDFEH4JApVUzlhHb6f9UhVec',
    appId: '1:867190690730:android:285fe879113ba8975291d3',
    messagingSenderId: '867190690730',
    projectId: 'goosit-8c0fb',
    storageBucket: 'goosit-8c0fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQ3NjvnZ7mGjcWRTVU3GQ7XwX-G7WaU3s',
    appId: '1:867190690730:ios:573855c7037a95a65291d3',
    messagingSenderId: '867190690730',
    projectId: 'goosit-8c0fb',
    storageBucket: 'goosit-8c0fb.appspot.com',
    iosClientId: '867190690730-qrbj9de9rag02i5ed3gj42vc6cl1sk0t.apps.googleusercontent.com',
    iosBundleId: 'com.example.goosit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQ3NjvnZ7mGjcWRTVU3GQ7XwX-G7WaU3s',
    appId: '1:867190690730:ios:573855c7037a95a65291d3',
    messagingSenderId: '867190690730',
    projectId: 'goosit-8c0fb',
    storageBucket: 'goosit-8c0fb.appspot.com',
    iosClientId: '867190690730-qrbj9de9rag02i5ed3gj42vc6cl1sk0t.apps.googleusercontent.com',
    iosBundleId: 'com.example.goosit',
  );
}

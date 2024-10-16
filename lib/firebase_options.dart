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
    apiKey: 'AIzaSyC-CuL2RRbKJWVCyt0vlkrh406F6LwvHRQ',
    appId: '1:560411514854:web:3aad7f624e4d98d65fe827',
    messagingSenderId: '560411514854',
    projectId: 'runner-app-df2e8',
    authDomain: 'runner-app-df2e8.firebaseapp.com',
    storageBucket: 'runner-app-df2e8.appspot.com',
    measurementId: 'G-2YZTYCGW3L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8KSwLQRi2rew5bbf4uOq27SqVdhe4_Fw',
    appId: '1:560411514854:android:a33f8056069212af5fe827',
    messagingSenderId: '560411514854',
    projectId: 'runner-app-df2e8',
    storageBucket: 'runner-app-df2e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_Ro6Dv5VYIKO_hvrU3mlygEoOtjFiv80',
    appId: '1:560411514854:ios:c3cd193a4b44f93f5fe827',
    messagingSenderId: '560411514854',
    projectId: 'runner-app-df2e8',
    storageBucket: 'runner-app-df2e8.appspot.com',
    iosClientId: '560411514854-lvcmisscs98i4oar2vv4r547s1b39sq1.apps.googleusercontent.com',
    iosBundleId: 'com.anany.runnerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_Ro6Dv5VYIKO_hvrU3mlygEoOtjFiv80',
    appId: '1:560411514854:ios:c3cd193a4b44f93f5fe827',
    messagingSenderId: '560411514854',
    projectId: 'runner-app-df2e8',
    storageBucket: 'runner-app-df2e8.appspot.com',
    iosClientId: '560411514854-lvcmisscs98i4oar2vv4r547s1b39sq1.apps.googleusercontent.com',
    iosBundleId: 'com.anany.runnerApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-CuL2RRbKJWVCyt0vlkrh406F6LwvHRQ',
    appId: '1:560411514854:web:a9f7f7da7ae8c16f5fe827',
    messagingSenderId: '560411514854',
    projectId: 'runner-app-df2e8',
    authDomain: 'runner-app-df2e8.firebaseapp.com',
    storageBucket: 'runner-app-df2e8.appspot.com',
    measurementId: 'G-XV6KZVS4KW',
  );

}
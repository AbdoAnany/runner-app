// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
//
// import '../notification/notification_bloc.dart';
// import '../notification_service/TokenMonitor.dart';
//
// class NotificationService {
//   // Private constructor
//   NotificationService._();
//   // Singleton instance
//   static final NotificationService _instance = NotificationService._();
//   // Factory constructor to return the same instance
//   factory NotificationService() => _instance;
//
//   late AndroidNotificationChannel channel;
//   bool isFlutterLocalNotificationsInitialized = false;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//
//   final url = 'https://abdoanany.pythonanywhere.com/pushFCM'; // Replace with your actual Firebase Cloud Function URL
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   late Future<void> Function(Map<String, dynamic> data) _onReceiveNotification;
//
//
//   Future<void> initialize() async {
//     // Request permission for iOS devices
//     // await _firebaseMessaging.requestPermission(
//     //   alert: true,
//     //
//     //   badge: true,
//     //   // sound: true,
//     // );
//     await setupFlutterNotifications();
//     await TokenMonitor.refreshToken();
//     // Configure FirebaseMessaging
//     FirebaseMessaging.onMessage.listen(_handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//
//     // Initialize local notifications
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('splash');
//     const initializationSettingsIOS = DarwinInitializationSettings();
//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//     subscribeToTopic('test');
//     subscribeToTopic('history');
//   }
//
//   Future<void> setupFlutterNotifications() async {
//     if (isFlutterLocalNotificationsInitialized) {
//       return;
//     }
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       description:
//       'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );
//
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (!kIsWeb) {
//       const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');
//       const DarwinInitializationSettings initializationSettingsDarwin =
//       DarwinInitializationSettings(
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//       const LinuxInitializationSettings initializationSettingsLinux =
//       LinuxInitializationSettings(defaultActionName: 'Open notification');
//
//       const InitializationSettings initializationSettings =
//       InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsDarwin,
//           macOS: initializationSettingsDarwin,
//           linux: initializationSettingsLinux);
//
//       _flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveBackgroundNotificationResponse:
//         onDidReceiveBackgroundNotificationResponse,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//       );
//
//       /// Create an Android Notification Channel.
//       ///
//       /// We use this channel in the `AndroidManifest.xml` file to override the
//       /// default FCM channel to enable heads up notifications.
//       await _flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//
//       /// Update the iOS foreground notification presentation options to allow
//       /// heads up notifications.
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       isFlutterLocalNotificationsInitialized = true;
//     }
//   }
//
//   Future<void> sendNotification({
//     required String title,
//     required String message,
//     required dynamic registrationTokens,
//     required Map<String, dynamic> data,
//     String? topic,
//   })
//   async {
//     final List<String> tokens = registrationTokens is String
//         ? [registrationTokens]
//         : List<String>.from(registrationTokens);
//     print('topic ${topic ?? 'topics'}');
//     print('tokens ${tokens ?? 'tokens'}');
//     final response = await http.post(
//       Uri.parse(url),
//       body: json.encode({
//         'title': title,
//         'msg': message,
//         'token': tokens.first,
//         'data': data,
//         'topic': topic ?? '',
//       }),
//       headers: {'Content-Type': 'application/json'},
//     );
//     print(data.toString());
//
//     if (response.statusCode == 200) {
//       print('Notification sent successfully');
//       print('Notification body ${response.body}');
//
//       var notificationBody = jsonDecode(response.body);
//       print('Notification body ${notificationBody['responses']}');
//
//       // _showLocalNotification(
//       //   notificationBody['title'],
//       //   notificationBody['body'],
//       //   notificationBody['data'],
//       // );
//     } else {
//       print('Failed to send notification. Status code: ${response.statusCode}');
//     }
//   }
//
//
//   void _handleMessage(RemoteMessage message) {
//     //  _notificationBloc.add(ReceiveXpNotification(xp, topic));
//
//     _showLocalNotification(message.notification!.title!, message.notification!.body!, message.data);
//   }
//
//   Future<void> _showLocalNotification(String title, String body, payload) async {
//     const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'xp_channel_id',
//       'XP Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//     const platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//         0, title, body, platformChannelSpecifics,
//         payload: payload.toString());
//   }
//
//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//   }
//
//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//   }
//
//
//   void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     /// this work when click on notification from app in foreground
//     print("onDidReceiveNotificationResponse 654");
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     print(notificationResponse.id);
//     print(notificationResponse.actionId);
//     print(notificationResponse.input);
//     print(notificationResponse.payload);
//     final Map<String, dynamic> data =
//     json.decode(notificationResponse.payload!);
//
//     await _onReceiveNotification(data);
//   }
//
//   static void onDidReceiveBackgroundNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     print("onDidReceiveBackgroundNotificationResponse 123");
//
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload1: $payload');
//     }
//   }
//
//   static void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload)
//   async {
//     print("onDidReceiveLocalNotification 123");
//     debugPrint('notification payload2: $payload');
//
//
//   }
// }

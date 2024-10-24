import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../notification/notification_bloc.dart';

class NotificationService {
  final url =
      'https://abdoanany.pythonanywhere.com/pushFCM'; // Replace with your actual Firebase Cloud Function URL

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationBloc _notificationBloc;

  NotificationService(this._notificationBloc) {
    initialize();
  }

  Future<void> initialize() async {
    // Request permission for iOS devices
    await _firebaseMessaging.requestPermission(
      alert: true,

      badge: true,
      // sound: true,
    );
    // Configure FirebaseMessaging
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('splash');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    subscribeToTopic('test');
    subscribeToTopic('history');
  }

  Future<void> sendNotification({
    required String title,
    required String message,
    required dynamic registrationTokens,
    required Map<String, dynamic> data,
    String? topic,
  }) async {
    final List<String> tokens = registrationTokens is String
        ? [registrationTokens]
        : List<String>.from(registrationTokens);
    print('topic ${topic ?? 'topics'}');
    print('tokens ${tokens ?? 'tokens'}');
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'title': title,
        'msg': message,
        'token': tokens.first,
        'data': data,
        'topic': topic ?? '',
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(data.toString());

    if (response.statusCode == 200) {
      print('Notification sent successfully');
      print('Notification body ${response.body}');

      var notificationBody = jsonDecode(response.body);
      print('Notification body ${notificationBody['responses']}');

      // _showLocalNotification(
      //   notificationBody['title'],
      //   notificationBody['body'],
      //   notificationBody['data'],
      // );
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }


  void _handleMessage(RemoteMessage message) {
    //  _notificationBloc.add(ReceiveXpNotification(xp, topic));

    _showLocalNotification(message.notification!.title!, message.notification!.body!, message.data);
  }

  Future<void> _showLocalNotification(String title, String body, payload) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'xp_channel_id',
      'XP Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: payload.toString());
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

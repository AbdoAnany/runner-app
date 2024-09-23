import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../notification/notification_bloc.dart';

class NotificationService {
  final url = 'https://abdoanany.pythonanywhere.com/pushFCM'; // Replace with your actual Firebase Cloud Function URL

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final NotificationBloc _notificationBloc;

  NotificationService(this._notificationBloc){
    initialize();
  }

  Future<void> initialize() async {
    // Request permission for iOS devices
    await _firebaseMessaging.requestPermission(

      alert: true,
      badge: true,
      sound: true,
    );
    // Configure FirebaseMessaging
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Initialize local notifications
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = DarwinInitializationSettings();
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    subscribeToTopic('test');
  }
  Future<void> sendXp({required int xp, required String topic, String? userId}) async {

    final Map<String, dynamic> data = {
      'xp': xp,
      'topic': topic,
      if (userId != null) 'userId': userId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('XP sent successfully');
      } else {
        print('Failed to send XP. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending XP: $e');
    }
  }
  Future<void> sendNotification({
    required String title,
    required String message,
    required dynamic registrationTokens,
    required Map<String, dynamic> data,
    String? topic,
  }) async {
    final List<String> tokens = registrationTokens is String ? [registrationTokens] : List<String>.from(registrationTokens);

    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'title': title,
        'msg': message,
        'registration_token': tokens,
        'data': data,
        'topic': topic,
      }),

      headers: {'Content-Type': 'application/json'},
    );
    print(data.toString());

    if (response.statusCode == 200) {
      print('Notification sent successfully');
      print('Notification body ${response.body}');
      var notificationBody=jsonDecode(response.body);
      _showLocalNotification(
        notificationBody['title'],
        notificationBody['body'],
        notificationBody['data'],


      );
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }
  Future<void> sendMassNotification({
    required String title,
    required String message,
    required Map<String, dynamic> data,
    String? topic,
  }) async {

    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'title': title,
        'msg': message,
        'data': data,
        'topic': topic,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      print('Mass notification sent successfully');
    } else {
      print('Failed to send mass notification. Status code: ${response.statusCode}');
    }
  }


  void _handleMessage(RemoteMessage message) {

  //  _notificationBloc.add(ReceiveXpNotification(xp, topic));

    _showLocalNotification(
      'XP Update',
      'You received xp XP for topic: topic',message.data
    );
  }

  Future<void> _showLocalNotification(String title, String body,payload) async {
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
      0,
      title,
      body,
      platformChannelSpecifics,payload: payload.toString()
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
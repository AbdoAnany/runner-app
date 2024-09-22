import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

// Model
class HistoryEntry {
  final int id;
  final DateTime date;
  final double distance;
  final int pt;
  final int kal;
  final int xp;

  HistoryEntry({
    required this.id,
    required this.date,
    required this.distance,
    required this.pt,
    required this.kal,
    required this.xp,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      id: json['id'],
      date: DateTime.parse(json['date']),
      distance: json['distance'].toDouble(),
      pt: json['pt'],
      kal: json['kal'],
      xp: json['xp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'distance': distance,
      'pt': pt,
      'kal': kal,
      'xp': xp,
    };
  }
}

// Events
abstract class NotificationEvent {}

class ReceiveXpNotification extends NotificationEvent {
  final int xp;
  final String topic;

  ReceiveXpNotification(this.xp, this.topic);
}

// States
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationReceived extends NotificationState {
  final HistoryEntry updatedEntry;

  NotificationReceived(this.updatedEntry);
}

// BLoC
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<ReceiveXpNotification>(_onReceiveXpNotification);
  }

  void _onReceiveXpNotification(ReceiveXpNotification event, Emitter<NotificationState> emit) {
    // Here you would typically update your data storage (e.g., database)
    // For this example, we'll just create a new HistoryEntry
    final updatedEntry = HistoryEntry(
      id: DateTime.now().millisecondsSinceEpoch,
      date: DateTime.now(),
      distance: 0,  // You might want to update this based on your logic
      pt: 0,        // You might want to update this based on your logic
      kal: 0,       // You might want to update this based on your logic
      xp: event.xp,
    );

    emit(NotificationReceived(updatedEntry));
  }
}

// Notification Service
class NotificationService {
  final url = 'https://abdoanany.pythonanywhere.com/pushFCM'; // Replace with your actual Firebase Cloud Function URL

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final NotificationBloc _notificationBloc;

  NotificationService(this._notificationBloc);

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
      print('Mass notification sent successfully');
    } else {
      print('Failed to send mass notification. Status code: ${response.statusCode}');
    }
  }


  void _handleMessage(RemoteMessage message) {
    if (message.data.containsKey('xp') && message.data.containsKey('topic')) {
      final xp = int.parse(message.data['xp']);
      final topic = message.data['topic'];

      _notificationBloc.add(ReceiveXpNotification(xp, topic));

      _showLocalNotification(
        'XP Update',
        'You received $xp XP for topic: $topic',
      );
    }
  }

  Future<void> _showLocalNotification(String title, String body) async {
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
      platformChannelSpecifics,
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

// Example usage in your app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized

  final notificationBloc = NotificationBloc();
  final notificationService = NotificationService(notificationBloc);
  await notificationService.initialize();

  runApp(MyApp(notificationBloc: notificationBloc, notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  final NotificationBloc notificationBloc;
  final NotificationService notificationService;

  const MyApp({Key? key, required this.notificationBloc, required this.notificationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider.value(
        value: notificationBloc,
        child: HomePage(notificationService: notificationService,),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final NotificationService notificationService;

  const HomePage({Key? key, required this.notificationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Notifications')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationReceived) {
                return Text('Latest XP Update: ${state.updatedEntry.xp}');
              }
              return Text('Waiting for updates...');
            },
          ),
          SizedBox(height: 20),

          // Button to send a test notification
          ElevatedButton(
            onPressed: () async {
              String? token = await FirebaseMessaging.instance.getToken();
              if (token != null) {
                notificationService.sendNotification(
                  title: 'Dynamic Notification',
                  topic: '/topics/test',
                  message: 'This is a test of dynamic data!',
                  registrationTokens: token,
                  data: {
                    'xp': '100',
                    'topic': '/topics/test',
                    'customField': {"data123": "dataMess"},
                  },
                );
              } else {
                print('Unable to get FCM token');
              }
            },
            child: Text('Send Test Notification'),
          ),

          SizedBox(height: 20),

          // Button to subscribe to a topic
          ElevatedButton(
            onPressed: () async {
              await notificationService.subscribeToTopic('test'); // Replace 'test' with your desired topic
              print('Subscribed to test topic');
            },
            child: Text('Subscribe to Topic'),
          ),

          SizedBox(height: 20),

          // Button to unsubscribe from a topic
          ElevatedButton(
            onPressed: () async {
              await notificationService.unsubscribeFromTopic('test'); // Replace 'test' with your desired topic
              print('Unsubscribed from test topic');
            },
            child: Text('Unsubscribe from Topic'),
          ),
        ],
      ),
    );
  }
}

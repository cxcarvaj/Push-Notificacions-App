// SHA1: 36:0B:FC:35:CB:92:DE:EA:D0:DE:94:20:0F:34:E0:6C:5C:A7:C0:90

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController<String>.broadcast();

  static Stream<String> get messageStream => _messageStream.stream;

  static Future<void> _onBackgroundHandler(RemoteMessage message) async {
    print(message.data);

    _messageStream.add(message.notification!.body ?? 'No data');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    _messageStream.add(message.notification!.body ?? 'No data');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.notification!.body ?? 'No data');
  }

  static Future<void> initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    token = await messaging.getToken();
    print('Token: $token');

    // Background Handler
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);

    // Foreground Handler
    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    // When the app is in the background and the user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}

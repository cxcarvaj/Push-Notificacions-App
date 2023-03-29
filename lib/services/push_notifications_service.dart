// SHA1: 36:0B:FC:35:CB:92:DE:EA:D0:DE:94:20:0F:34:E0:6C:5C:A7:C0:90

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future<void> _onBackgroundHandler(RemoteMessage message) async {
    print('onBackground Handler: ${message.messageId}');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    print('onMessage Handler: ${message.messageId}');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp Handler: ${message.messageId}');
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
}

import 'package:flutter/material.dart';
import 'package:notifications_app/screens/screens.dart';
import 'package:notifications_app/services/push_notifications_service.dart';

void main() async {
  //* This is to ensure that the app is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    //* Here we have access to the context of the app.
    PushNotificationService.messageStream.listen((product) {
      print('MyApp: $product');

      navigatorKey.currentState?.pushNamed('/message', arguments: product);
      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(product),
          // action: SnackBarAction(
          //   label: 'Go',
          //   onPressed: () => navigatorKey.currentState!.pushNamed('/message'),
          // ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/home',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      routes: {
        '/home': (_) => const HomeScreen(),
        '/message': (_) => const MessageScreen(),
      },
    );
  }
}

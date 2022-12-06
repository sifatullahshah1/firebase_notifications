import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/screen_notification.dart';
import 'package:firebase_notifications/widgets_reusing.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseOnBackgroundMessageHandle(RemoteMessage message) async {
  try {
    print("FirebaseMessaging ${message.notification!.title}");
    print("FirebaseMessaging ${message.notification!.body}");
  } catch (e) {
    print("FirebaseMessaging Error ${e.toString()}");
  }
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundMessageHandle);

    runApp(const UrraanFirebaseNotification());
  } catch (e) {
    print("FirebaseMessaging Error ${e.toString()}");
  }
}

class UrraanFirebaseNotification extends StatefulWidget {
  const UrraanFirebaseNotification({super.key});

  @override
  State<UrraanFirebaseNotification> createState() =>
      _UrraanFirebaseNotificationState();
}

class _UrraanFirebaseNotificationState
    extends State<UrraanFirebaseNotification> {
  //

  final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  void _FirebaseOnMessageNotificationHandle() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FirebaseMessaging onMessage");

      if (message != null) {
        _notificationHandler(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("FirebaseMessaging onMessageOpenedApp");

      if (message != null) {
        _notificationHandler(message);
      }
    });
  }

  void _notificationHandler(RemoteMessage message) async {
    try {
      Map<String, dynamic> sss = message.data;

      print("objectobject 1 ${message.notification!.title}");
      print("objectobject 2 ${message.notification!.body}");
      print("objectobject 3 ${message.data.toString()}");
      print("objectobject 4 ${message.data["roll_no"]}");
      print("objectobject 5 ${message.data["notification_type"]}");

      navigatorState.currentState!.pushNamed("/notification_screen",
          arguments: message.data["notification_type"]);
    } catch (e) {
      print("objectobject ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // //
    firebaseMessaging.getToken().then((value) {
      print("FirebaseMessaging Token ; ${value}");
    });

    _FirebaseOnMessageNotificationHandle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      debugShowCheckedModeBanner: false,
      title: 'Firebaes Notification',
      theme: ThemeData(primarySwatch: Colors.blue),
      // routes: {
      //   "/": (context) => Scaffold(
      //         appBar: AppBar(title: Text("Notification 1st Screen")),
      //         floatingActionButton: FloatingActionButton(
      //           onPressed: () {
      //             WidgetsReusing.getSnakeBar(
      //                 navigatorState.currentState!.context, "message");
      //           },
      //           child: Icon(Icons.message),
      //         ),
      //         body: Container(),
      //       ),
      //   "/notification_screen": (context) => ScreenNotification(),
      // },

      onGenerateRoute: GetRoutes,
    );
  }

  Route<dynamic> GetRoutes(RouteSettings settings) {
    if (settings.name == "/notification_screen") {
      return MaterialPageRoute(
        builder: (builder) => ScreenNotification(
            notification_title: settings.arguments.toString()),
      );
    } else {
      return MaterialPageRoute(
        builder: (builder) => Scaffold(
          appBar: AppBar(title: Text("Notification 1st Screen")),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              WidgetsReusing.getSnakeBar(
                  navigatorState.currentState!.context, "message");
            },
            child: Icon(Icons.message),
          ),
          body: Container(),
        ),
      );
    }
  }
}

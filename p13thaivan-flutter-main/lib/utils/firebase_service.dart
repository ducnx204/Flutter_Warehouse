import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:template/di_container.dart';
import 'package:template/notification/my_notification.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

class FirebaseService {
  FirebaseService() {
    init();
  }

  Future<void> init() async {
    // init firebase
    await Firebase.initializeApp();

    // set up fcm notification
    FirebaseMessaging.instance.subscribeToTopic('fcm_p08yamamoto');

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (!kIsWeb) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      String? token = await messaging.getToken();

      // save device token
      sl.get<SharedPreferenceHelper>().savedeviceToken(token.toString());
      
      print(token);
    }

    // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // int? _orderID;
    // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //   _orderID = (notificationAppLaunchDetails!.payload != null &&
    //           notificationAppLaunchDetails.payload!.isNotEmpty)
    //       ? int.parse(notificationAppLaunchDetails.payload.toString())
    //       : null;
    // }
    // await MyNotification.initialize(flutterLocalNotificationsPlugin);
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }
}

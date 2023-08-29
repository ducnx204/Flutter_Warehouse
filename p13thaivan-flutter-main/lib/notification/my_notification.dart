import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:path_provider/path_provider.dart';

// ignore: avoid_classes_with_only_static_members
class MyNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const androidInitialize =
        AndroidInitializationSettings('notification_icon');
    const iOSInitialize = IOSInitializationSettings();
    const initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
          // handle event go to screen when click notification
          // MyApp.navigatorKey.currentState.push(
          //     MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderModel: null, orderId: int.parse(payload))));
        }
      } catch (e){
        print(e);
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: ${message.data}');
      MyNotification.showNotification(
          message.data, flutterLocalNotificationsPlugin);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageApp: ${message.data}');
    });
  }

  static Future<void> showNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    if (message['image'] != null && (message['image'].toString().isNotEmpty)) {
      try {
        await showBigPictureNotificationHiddenLargeIcon(message, fln);
      } catch (e) {
        await showBigTextNotification(message, fln);
      }
    } else {
      await showBigTextNotification(message, fln);
    }
  }

  static Future<void> showTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    final String _title = message['title'].toString();
    final String _body = message['body'].toString();
    final String _orderID = message['order_id'].toString();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics,
        payload: _orderID);
  }

  static Future<void> showBigTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    final String _title = message['title'].toString();
    final String _body = message['body'].toString();
    final String _orderID = message['order_id'].toString();
    final BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      _body,
      htmlFormatBigText: true,
      contentTitle: _title,
      htmlFormatContentTitle: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      'big text channel description',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics,
        payload: _orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    final String _title = message['title'].toString();
    final String _body = message['body'].toString();
    final String _orderID = message['order_id'].toString();
    final String _image = message['image'].toString().startsWith('http')
        ? message['image'].toString()
        : '${app_constants.BASE_URL}/storage/app/public/notification/${message['image']}';
    final String largeIconPath =
        await _downloadAndSaveFile(_image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(_image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: _title,
      htmlFormatContentTitle: true,
      summaryText: _body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      'big text channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('notification'),
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics,
        payload: _orderID);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data as List<int>);
    return filePath;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print('background: ${message.data}');
  const androidInitialize = AndroidInitializationSettings('notification_icon');
  const iOSInitialize = IOSInitializationSettings();
  const initializationsSettings =
      InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  MyNotification.showNotification(
      message.data, flutterLocalNotificationsPlugin);
}

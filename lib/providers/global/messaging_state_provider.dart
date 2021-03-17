import 'package:e_revenue_flutter/models/notifications_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messagingProvider =
    StateNotifierProvider((ref) => MessagingStateNotifier(ref.watch, ref.read));

class MessagingStateNotifier extends StateNotifier<List<NotificationData>> {
  final watch;
  final Reader read;

  MessagingStateNotifier(this.watch, this.read, [List<NotificationData> state])
      : super(state ?? []) {
    // initMessaging();
  }

  initMessaging(bool loggedIn) async {
    if (!loggedIn) {
      return;
    }
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await sendUserDeviceToken();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  icon: android?.smallIcon,
                  playSound: true,
                  enableVibration: true,
                  importance: Importance.high),
            ));
        // if (notification.title.contains("Help Request")) {
        //   read(helpReloadProvider).state =
        //       !read(helpReloadProvider).state;
        // }
        // if (notification.title.contains("booking") ||
        //     notification.body.contains("booking")) {
        //   read(bookingsReloadProvider).state =
        //       !read(bookingsReloadProvider).state;
        //   read(reloadHomeChangeProvider).state =
        //       !read(reloadHomeChangeProvider).state;
        // }
        // read(notificationDetailsApiService).getNotifications();
      }
    });
  }

  /// Send the current user's device token
  Future<void> sendUserDeviceToken() async {
    // final token = await read(apiTokenProvider.future);
    final firebaseToken = await FirebaseMessaging.instance.getToken();

    print('device Id $firebaseToken');

    return firebaseToken;

    // http.Response response = await http.post(
    //     Uri.encodeFull("$mgariBaseUrl/user/device/token"),
    //     body: firebaseToken,
    //     headers: {
    //       'Accept': 'application/json',
    //       'Content-type': 'application/json',
    //       'Authorization': "Bearer $token"
    //     });

    // if (response.statusCode != 200) {
    //   print(
    //       "Could not send firebase messaging token. Code: ${response.statusCode}. Message: ${response.body}");
    // }
  }
}

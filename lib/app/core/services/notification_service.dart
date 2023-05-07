import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as fz;
// import 'package:timezone/standalone.dart' ;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('logo_tickmind_removebg');

  void initializeNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationPlugin.initialize(initializationSettings);
     fz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterTimezone
            .getLocalTimezone(), // await FlutterNativeTimezone.getLocalTimezone(),
      ),
    );
  }

  void sendNotification({required String title, required String body}) async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails('chanelId', 'chanelName',
            priority: Priority.high, importance: Importance.max));
    await _flutterLocalNotificationPlugin.show(
        12, title, body, notificationDetails);
  }

  void scheduleNotification(
      {required String title,
      required String body,
      required DateTime time,
      required int id}) async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails('chanelId', 'chanelName',
            priority: Priority.high, importance: Importance.max));

    //  await _flutterLocalNotificationPlugin.show(12, title, body, notificationDetails);
    await _flutterLocalNotificationPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(time, tz.local), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}

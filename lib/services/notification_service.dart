
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService{
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async{
    _notifications.show(id,title, body, await _notificationDetails(), payload: payload);
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async{
    _notifications.zonedSchedule(
        id,title, body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(), payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future showRepeatScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required int date,
    int? minute,
  }) async{
    int min = minute != null? minute : 0;
    _notifications.zonedSchedule(
      id,title, body,
      _scheduleDaily(Time(date, min)),
      await _notificationDetails(), payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduleDate.isBefore(now) ?
      scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'Informa',
        channelDescription: 'channel description',
        importance: Importance.max,
        playSound: true
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async{
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(
      android: android,
      iOS: ios,
    );
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload){
        onNotifications.add(payload);
      }
    );
    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future cancelNotification(int id) async{
    await _notifications.cancel(id);
  }

  static Future cancelAllNotification() async{
    await _notifications.cancelAll();
  }

  // Future setNotifications(AppUser user) async{
  //   await NotificationService.init(initScheduled: true);
  //   listenNotification();
  //   NotificationService.showRepeatScheduledNotification(
  //     id: 20,
  //     title: 'وقت التمرين',
  //     body: 'يلا يا بطل استعد عشان نتمرن 💪🏻',
  //     payload: 'payload',
  //     date: user.trainingTime!.hour,
  //   );
  //   for(int i=0; i<user.numberOfMeals; i++){
  //     NotificationService.showRepeatScheduledNotification(
  //       id: 30+i,
  //       title: 'وجبة ' + (i+1).toString() + ' 🍴',
  //       body: 'دلوقتي معاد الوجبة ' + (i+1).toString(),
  //       payload: 'payload',
  //       date: user.trainingTime!.hour,
  //     );
  //   }
  // }

}
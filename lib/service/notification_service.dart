import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _notifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  // ฟังก์ชัน: ตั้งเวลาแจ้งเตือนล่วงหน้า
  static Future<void> scheduleWaterReminders() async {
    await _notifications.cancelAll();

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'water_id',
        'Water Reminder',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // วนลูปตั้งเวลาล่วงหน้า 8 ครั้ง
    for (int i = 1; i <= 8; i++) {
      await _notifications.zonedSchedule(
        i,
        'ดื่มน้ำกันเถอะ! 💧',
        'อย่าลืมดื่มน้ำให้ครบตามเป้าหมายนะ',
        tz.TZDateTime.now(tz.local).add(Duration(hours: i)),
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  //ฟังก์ชัน: ยกเลิกการเตือนทั้งหมด
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}

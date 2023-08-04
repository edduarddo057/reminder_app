
import 'package:reminder_app/entity/reminder.dart';

class ReminderGroup {
  ReminderGroup(
      {required this.title,
       this.isExpanded = false,
       required this.listReminders});

  String title;
  bool isExpanded;
  List<Reminder> listReminders;
}


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/entity/reminder.dart';
import 'package:reminder_app/entity/reminder_group.dart';
import 'package:reminder_app/widgets/list_reminder.dart';
import 'package:reminder_app/widgets/form_reminder.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final List<ReminderGroup> _data = [];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _form = GlobalKey<FormState>();

  void sortList() {
    widget._data.sort((a, b) => DateFormat("dd/MM/yyyy").parse(a.title).compareTo(DateFormat("dd/MM/yyyy").parse(b.title)));
  }

  void addReminder(String description, String date) {
    if (_form.currentState!.validate()) {
      var index = widget._data.indexWhere((element) => element.title == date);
      if (index != -1) {
        setState(() {
          widget._data[index].listReminders
              .add(Reminder(description: description, date: date));
        });
      } else {
        setState(() {
          widget._data.add(ReminderGroup(
              title: date,
              listReminders: [Reminder(description: description, date: date)]));
          sortList();
        });
      }
      _form.currentState!.reset();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lembrete adicionado com sucesso!", style: TextStyle(color: Color(0xFF001F23))),backgroundColor: Color(0xFFBCEBF2)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: ReminderList(listDate: widget._data),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ReminderForm(form: _form, actionButton: addReminder),
                        ),
                      ),
                    );
                  },
                );
              },
              tooltip: 'Adicionar lembrete',
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}

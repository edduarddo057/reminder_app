import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderForm extends StatefulWidget {
  ReminderForm({super.key, required this.form, required this.actionButton});

  GlobalKey<FormState> form;
  Function(String description, String date) actionButton;

  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final _dateForm = TextEditingController();
  final _descriptionForm = TextEditingController();

  Future<DateTime?> _showDatePicker() {
    return showDatePicker(
      context: context,

      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days:1)),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.form,
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: const Text("Novo Lembrete",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16))),
            TextFormField(
                controller: _dateForm,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                    hintText: "DD/MM/AAAA",
                    border: OutlineInputBorder(),
                    label: Text("Data do lembrete"),
                    prefixIcon:
                    Icon(Icons.calendar_month)),
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preencha a data";
                  }
                  return null;
                },
                onTap: () async {
                  var pickedDate =
                  await _showDatePicker();
                  if (pickedDate != null) {
                    setState(() {
                      _dateForm.text =
                          DateFormat("dd/MM/yyyy")
                              .format(pickedDate);
                    });
                  }
                }),
            TextFormField(
              controller: _descriptionForm,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                  hintText: "Escreva o lembrete",
                  border: OutlineInputBorder(),
                  label: Text("Nome do lembrete"),
                  prefixIcon:
                  Icon(Icons.short_text_outlined)),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Preencha a descrição";
                }
                return null;
              },
            ),
            Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD5E8D0)),
                      child: const Text("Cancelar"),
                      onPressed: () {
                        widget.form.currentState!.reset();
                        Navigator.pop(context);
                      }),
                  ElevatedButton(
                      onPressed: () {
                        widget.actionButton(_descriptionForm.text,
                            _dateForm.text);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD5E8D0)),
                      child: const Text("Criar"))
                ])
          ],
        ));
  }
}

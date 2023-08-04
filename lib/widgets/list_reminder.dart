import 'package:flutter/material.dart';
import '../entity/reminder_group.dart';

class ReminderList extends StatefulWidget {
   const ReminderList({super.key, required this.listDate});

  final List<ReminderGroup> listDate;

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    return widget.listDate.isNotEmpty ? ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.listDate[index].isExpanded = !isExpanded;
        });
      },
      children: widget.listDate
          .map<ExpansionPanel>((ReminderGroup reminderGroup) =>
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(reminderGroup.title),
              );
            },
            body: Column(
                children: reminderGroup.listReminders
                    .map((e) => ListTile(
                  title: Text(e.description),
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 8, 10),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder:
                            (BuildContext context) =>
                            AlertDialog(
                              title: const Text(
                                  'Excluir'),
                              content: const Text(
                                  'Deseja excluir o lembrete ?'),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD5E8D0)),
                                  onPressed: () =>
                                      Navigator.pop(context),
                                  child:
                                  const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    var indexList = widget
                                        .listDate
                                        .indexOf(
                                        reminderGroup);
                                    setState(() {
                                      widget
                                          .listDate[indexList]
                                          .listReminders
                                          .remove(e);
                                      if (widget
                                          .listDate[indexList]
                                          .listReminders
                                          .isEmpty) {
                                        widget.listDate.remove(
                                            reminderGroup);
                                      }
                                    });
                                    Navigator.pop(
                                        context);
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD5E8D0)),
                                  child: const Text('Confirmar'),
                                ),
                              ],
                            ),
                      )),
                ))
                    .toList()),
            isExpanded: reminderGroup.isExpanded,
          ))
          .toList(),
    ): Center(child: Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
    child: const Text("Nenhum lembrete adicionado"),
    ));
  }
}

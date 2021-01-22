import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class QuestListPage extends StatefulWidget {
  @override
  _QuestListPageState createState() => _QuestListPageState();
}

class _QuestListPageState extends ModularState<QuestListPage, QuestController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quest List"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            child: AddQuestDialog(
              controller: controller,
            ),
          ).then(
            (_) => setState(() => {}),
          );
        },
      ),
      body: FutureBuilder(
        future: controller.updateQuestList().then((value) => debugPrint(value)),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: controller.questList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                                    child: ListTile(
                      title: Text(controller.questList[index].name),
                      subtitle: Text(controller.questList[index].description),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}

class AddQuestDialog extends StatefulWidget {
  final QuestController controller;

  const AddQuestDialog({Key key, @required this.controller}) : super(key: key);

  @override
  _AddQuestDialogState createState() => _AddQuestDialogState();
}

class _AddQuestDialogState extends State<AddQuestDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(8.0 * 2),
      title: Text("Create Quest"),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextField(
            onChanged: (value) => widget.controller.dto = widget.controller.dto.copyWith(name: value),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextField(
            onChanged: (value) => widget.controller.dto = widget.controller.dto.copyWith(description: value),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description",
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleDialogOption(
              child: Text("Create".toUpperCase()),
              onPressed: () {
                widget.controller.save().then((value) => debugPrint(value));
                Navigator.of(context).pop();
              },
            ),
            SimpleDialogOption(
              child: Text("Cancel".toUpperCase()),
              onPressed: () {
                debugPrint("cancelou");
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}

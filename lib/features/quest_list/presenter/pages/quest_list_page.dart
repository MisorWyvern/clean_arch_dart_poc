import 'package:clean_arch_dart_poc/core/widgets/custom_alert_dialog.dart';
import 'package:clean_arch_dart_poc/core/widgets/custom_list_tile.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.help_rounded),
            onPressed: () {},
            tooltip: "Help",
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
            tooltip: "Settings",
          ),
        ],
        title: Text("Daily Quests List"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).textTheme.headline1.color,
        ),
        onPressed: () {
          Modular.link.pushNamed("/addquest");
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
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: controller.questList?.length ?? 0,
                  itemBuilder: (_, index) {
                    return CustomListTile(
                      onCheckIconPressed: (){},
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) => CustomAlertDialog(
                            title: "Would you like to delete this Quest?",
                            bodyText:
                                "Quest:\n${controller.questList[index].name}\n${controller.questList[index].description}",
                            onConfirm: () async {
                              String result = await controller
                                  .delete(controller.questList[index].id);
                              debugPrint(result);
                              Modular.to.pop();
                            },
                          ),
                          barrierDismissible: false,
                        );
                      },
                      name: controller.questList[index].name,
                      description: controller.questList[index].description,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

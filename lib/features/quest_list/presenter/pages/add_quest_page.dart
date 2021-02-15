import 'package:clean_arch_dart_poc/core/widgets/custom_button.dart';
import 'package:clean_arch_dart_poc/core/widgets/custom_list_tile.dart';
import 'package:clean_arch_dart_poc/core/widgets/custom_text_field.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/add_quest_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddQuestPage extends StatefulWidget {
  @override
  _AddQuestPageState createState() => _AddQuestPageState();
}

class _AddQuestPageState
    extends ModularState<AddQuestPage, AddQuestPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new DailyQ"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextField(
                  icon: Icons.wysiwyg,
                  label: "Name",
                  onChanged: (value) => controller.name = value,
                ),
                CustomTextField(
                  icon: Icons.subject,
                  label: "Description",
                  onChanged: (value) => controller.description = value,
                ),
                CustomButton(
                  text: "create",
                  onTap: () async {
                    if (controller.isValidDto == false) return;
                    String result = await controller.save();
                    debugPrint(result);
                    Modular.to.pop();
                  },
                ),
                Text(
                  "Preview:",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Observer(
                  builder: (_) {
                    return CustomListTile(
                        name: controller.name,
                        description: controller.description);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

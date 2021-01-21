import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/layers/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/layers/domain/usecases/quest_usecase.dart';
import 'package:clean_arch_dart_poc/layers/domain/usecases/quest_usecase_imp.dart';
import 'package:clean_arch_dart_poc/layers/external/datasources/sqflite/quest_datasource_imp.dart';
import 'package:clean_arch_dart_poc/layers/infra/datasources/quest_datasource.dart';
import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';
import 'package:clean_arch_dart_poc/layers/infra/mapper/quest_mapper.dart';
import 'package:clean_arch_dart_poc/layers/infra/repositories/quest_repository_imp.dart';
import 'package:clean_arch_dart_poc/layers/presenter/controller/quest_controller.dart';
import 'package:flutter/material.dart';

class QuestListPage extends StatefulWidget {
  @override
  _QuestListPageState createState() => _QuestListPageState();
}

class _QuestListPageState extends State<QuestListPage> {
  List<QuestDTO> quests = [];
  QuestController controller;

  _QuestListPageState() {
    Mapper _mapper = QuestMapper();
    QuestDataSource _datasource = QuestDataSourceImp();
    QuestRepository _repository = QuestRepositoryImp(_datasource, _mapper);
    QuestUseCase _useCase = QuestUseCaseImp(_repository);
    controller = QuestController(_useCase, _mapper);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quest List Page"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, child: AddQuestDialog());
        },
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)).then(
            (value) => controller.getQuests().then((value) => quests = value)),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (quests.length <= 0) {
            return Center(
              child: Text("No quests created..."),
            );
          }

          return ListView.builder(
              itemCount: quests.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(quests[index].name),
                );
              });
        },
      ),
    );
  }
}

class AddQuestDialog extends StatefulWidget {
  @override
  _AddQuestDialogState createState() => _AddQuestDialogState();
}

class _AddQuestDialogState extends State<AddQuestDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Create Quest"),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleDialogOption(
              child: Text("Create"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}

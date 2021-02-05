import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return false when verifying an invalid quest", () {
    Quest invalidQuest = Quest();

    expect(invalidQuest.isValidQuest, false);
  });

  test("Should return true when verifying a valid quest", () {
    Quest validQuest = Quest(
      id: null,
      name: "test name",
      description: "test desc",
    );

    expect(validQuest.isValidQuest, true);
  });
}

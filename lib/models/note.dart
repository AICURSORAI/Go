import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late List<String> tags;

  @HiveField(3)
  late String moodIcon;

  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  late DateTime updatedAt;

  Note({
    required this.title,
    required this.content,
    required this.tags,
    required this.moodIcon,
    required this.createdAt,
    required this.updatedAt,
  });
}



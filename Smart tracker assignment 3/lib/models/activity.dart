import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 0)
class Activity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime timestamp;

  @HiveField(2)
  double latitude;

  @HiveField(3)
  double longitude;

  @HiveField(4)
  String? imagePath; // local file path to attached image

  @HiveField(5)
  String? notes;

  Activity({
    required this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.imagePath,
    this.notes,
  });
}

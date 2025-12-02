import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  final Box<Activity> _box = Hive.box<Activity>('activities');
  final _uuid = const Uuid();

  List<Activity> get activities {
    final all = _box.values.toList();
    // keep newest first
    all.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return all;
  }

  Future<void> addActivity({
    required double lat,
    required double lon,
    String? imagePath,
    String? notes,
  }) async {
    final a = Activity(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      latitude: lat,
      longitude: lon,
      imagePath: imagePath,
      notes: notes,
    );
    await _box.put(a.id, a);
    // enforce max 5 most recent
    if (_box.length > 5) {
      final oldestKey = _box.keys.cast<String>().first;
      await _box.delete(oldestKey);
    }
    notifyListeners();
  }

  Future<void> deleteActivity(String id) async {
    await _box.delete(id);
    notifyListeners();
  }
}

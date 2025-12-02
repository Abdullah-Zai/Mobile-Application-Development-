import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseActivityService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final _uuid = const Uuid();

  // Upload image to Firebase Storage
  static Future<String?> uploadImage(File file) async {
    try {
      final id = _uuid.v4();
      final ref = _storage.ref().child('activity_images/$id.jpg');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  // Save activity to Firestore
  static Future<void> saveActivity({
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    String? imageUrl,
    String? notes,
  }) async {
    await _firestore.collection('activities').add({
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'imageUrl': imageUrl,
      'notes': notes,
    });
  }

  // Fetch activities (sorted newest first)
  static Stream<QuerySnapshot> getActivities() {
    return _firestore
        .collection('activities')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

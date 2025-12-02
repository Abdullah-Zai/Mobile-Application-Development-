import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activity_provider.dart';
import '../models/activity.dart';
import '../services/location_service.dart';
import '../services/camera_service.dart';
import '../services/firebase_activity_service.dart';
import 'activity_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);
    final activities = provider.activities;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartTracker — Home'),
      ),

      body: Column(
        children: [
          const SizedBox(height: 15),

          // ---------------- GPS BUTTON ----------------
          ElevatedButton(
            onPressed: () async {
              final pos = await LocationService.getCurrentLocation();
              if (pos == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('⚠️ Location denied or GPS is off'),
                  ),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Your Location → Lat: ${pos.latitude}, Lon: ${pos.longitude}'),
                ),
              );
            },
            child: const Text('Get Current GPS Location'),
          ),

          const SizedBox(height: 12),

          // ---------------- ADD ACTIVITY (Camera + GPS + Firebase) ----------------
          ElevatedButton(
            onPressed: () async {
              // Step 1: GPS location
              final pos = await LocationService.getCurrentLocation();
              if (pos == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Location denied or GPS is OFF')),
                );
                return;
              }

              // Step 2: Capture Image
              final imageFile = await CameraService.pickImageFromCamera();
              if (imageFile == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No image captured')),
                );
                return;
              }

              // Step 3: Upload to Firebase Storage
              final imageUrl =
              await FirebaseActivityService.uploadImage(imageFile);

              // Step 4: Save to Firestore
              await FirebaseActivityService.saveActivity(
                latitude: pos.latitude,
                longitude: pos.longitude,
                timestamp: DateTime.now(),
                imageUrl: imageUrl,
                notes: "Synced activity",
              );

              // Step 5: Save locally using Hive
              await provider.addActivity(
                lat: pos.latitude,
                lon: pos.longitude,
                notes: 'Synced Activity',
                imagePath: imageFile.path,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Activity saved successfully!')),
              );
            },
            child: const Text('Add Activity (Camera + GPS + Firebase)'),
          ),

          const SizedBox(height: 12),

          // ---------------- ADD TEST ACTIVITY BUTTON ----------------
          ElevatedButton(
            onPressed: () async {
              await provider.addActivity(
                lat: 31.5204,
                lon: 74.3587,
                notes: 'Test activity saved',
              );
            },
            child: const Text('Add Test Activity'),
          ),

          const SizedBox(height: 12),

          // ---------------- GO TO FIRESTORE HISTORY ----------------
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ActivityHistoryScreen()),
              );
            },
            child: const Text('View Online Activity History'),
          ),

          const SizedBox(height: 20),

          const Text(
            "Local Recent Activities:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // ---------------- LOCAL ACTIVITY LIST (Hive) ----------------
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, idx) {
                final Activity a = activities[idx];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: a.imagePath != null
                        ? Image.asset(
                      a.imagePath!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.location_on, size: 35),

                    title: Text(
                      a.notes ?? "Activity at ${a.timestamp}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      'Lat: ${a.latitude}, Lon: ${a.longitude}\nTime: ${a.timestamp.toString().split(".")[0]}',
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => provider.deleteActivity(a.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

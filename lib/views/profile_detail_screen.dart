import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class ProfileDetailScreen extends StatelessWidget {
  final Profile profile;

  ProfileDetailScreen({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(profile.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profile.avatar),
            ),
            SizedBox(height: 20),
            Text(
              profile.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              profile.email,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit screen
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'edit_profile_screen.dart'; // Import the EditProfileScreen

class ProfileScreen extends StatelessWidget {
  final Contact contact;

  const ProfileScreen({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,

        backgroundColor: const Color(0xFF6D1B5E), // Adjust color

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(contact.imageUrl),
                ),
                const Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(Icons.star, color: Colors.orange, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            contact.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          OutlinedButton(
            onPressed: () {
              // Navigate to Edit Profile Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(contact: contact),
                ),
              );
            },
            child: const Text("Edit profile"),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                const Icon(Icons.email, color: Colors.black54),
                const SizedBox(width: 10),
                Text(contact.email, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle send email action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB90A5D),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Send Email",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

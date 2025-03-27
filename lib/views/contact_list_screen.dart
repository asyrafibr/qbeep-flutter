import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../widgets/contact_tile.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [
    Contact(
      name: "Fullsnack Designer",
      email: "fendy27@gmail.com",
      imageUrl: "https://example.com/avatar1.png",
    ),
    Contact(
      name: "Albert Bell",
      email: "albert.bell@example.com",
      imageUrl: "https://example.com/avatar2.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contact: contacts[index],
            onDelete: () {
              setState(() {
                contacts.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}

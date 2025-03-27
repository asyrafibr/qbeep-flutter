import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'contact_tile.dart';
import 'models/contact.dart';
import 'edit_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [
    Contact(
      name: "Darlene Steward",
      email: "darlene.steward7@gmail.com",
      imageUrl: "https://example.com/profile1.jpg",
      isFavorite: true,
    ),
    Contact(
      name: "Fullsnack Designer",
      email: "fendy27@gmail.com",
      imageUrl: "https://example.com/profile2.jpg",
      isFavorite: false,
    ),
    Contact(
      name: "Lee Williamson",
      email: "leewilliamson76@gmail.com",
      imageUrl: "https://example.com/profile3.jpg",
      isFavorite: false,
    ),
    Contact(
      name: "Ronald Mccoy",
      email: "ronald.mccoy3@gmail.com",
      imageUrl: "https://example.com/profile4.jpg",
      isFavorite: false,
    ),
    Contact(
      name: "Albert Bell",
      email: "albert.bell@gmail.com",
      imageUrl: "https://example.com/profile5.jpg",
      isFavorite: false,
    ),
  ];

  String searchQuery = "";
  bool showFavorites = false;

  void _editContact(int index, Contact updatedContact) {
    setState(() {
      contacts[index] = updatedContact;
    });
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void _addContact(Contact newContact) {
    setState(() {
      contacts.add(newContact);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Contact> filteredContacts =
        contacts.where((contact) {
          final matchesSearch =
              contact.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              contact.email.toLowerCase().contains(searchQuery.toLowerCase());
          return showFavorites
              ? contact.isFavorite && matchesSearch
              : matchesSearch;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Contact",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6D1B5E), // Dark maroon color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => setState(() => searchQuery = query),
              decoration: InputDecoration(
                hintText: "Search contact",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Bubble shape
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ),

          // 🏷️ Filter Buttons ("All" & "Favourite")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => showFavorites = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showFavorites
                            ? Colors.grey.shade300
                            : const Color(0xFF6D1B5E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "All",
                    style: TextStyle(
                      color: showFavorites ? Colors.black54 : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() => showFavorites = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showFavorites
                            ? const Color(0xFF6D1B5E)
                            : Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Favourite",
                    style: TextStyle(
                      color: showFavorites ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 📜 Contact List
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                return ContactTile(
                  contact: filteredContacts[index],
                  onDelete: () => _deleteContact(index),
                  onEdit:
                      (updatedContact) => _editContact(index, updatedContact),
                );
              },
            ),
          ),
        ],
      ),

      // ➕ Floating Action Button (FAB) to Add a New Contact
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => EditContactScreen(
                    contact: Contact(
                      name: '',
                      email: '',
                      imageUrl: '',
                      isFavorite: false,
                    ),
                  ),
            ),
          );

          if (newContact != null && newContact is Contact) {
            _addContact(newContact);
          }
        },
        backgroundColor: const Color(0xFF6D1B5E), // Dark maroon
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: ProfileListScreen(), debugShowCheckedModeBanner: false),
  );
}

class ProfileListScreen extends StatefulWidget {
  @override
  _ProfileListScreenState createState() => _ProfileListScreenState();
}

class _ProfileListScreenState extends State<ProfileListScreen> {
  List<Map<String, dynamic>> allContacts = [
    {
      "name": "Darlene Steward",
      "email": "darlene.steward7@gmail.com",
      "image": "assets/avatar1.png",
      "favorite": true,
    },
    {
      "name": "Fullsnack Designer",
      "email": "fendy27@gmail.com",
      "image": "assets/avatar2.png",
      "favorite": false,
    },
    {
      "name": "Lee Williamson",
      "email": "lee.williamson76@gmail.com",
      "image": "assets/avatar3.png",
      "favorite": true,
    },
    {
      "name": "Ronald Mccoy",
      "email": "ronald.mccoy39@gmail.com",
      "image": "assets/avatar4.png",
      "favorite": false,
    },
    {
      "name": "Albert Bell",
      "email": "albert.bell@gmail.com",
      "image": "assets/avatar5.png",
      "favorite": true,
    },
  ];

  List<Map<String, dynamic>> displayedContacts = [];
  bool showFavorites = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedContacts = List.from(allContacts);
  }

  void filterContacts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      displayedContacts =
          allContacts.where((contact) {
            bool matchesSearch = contact["name"].toLowerCase().contains(query);
            bool matchesFavorite = !showFavorites || contact["favorite"];
            return matchesSearch && matchesFavorite;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF702846), // Maroon Color
        title: Text(
          "My contact",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: (value) => filterContacts(),
              decoration: InputDecoration(
                hintText: "Search contact",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Filter Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterButton("All", !showFavorites, () {
                setState(() {
                  showFavorites = false;
                  filterContacts();
                });
              }),
              SizedBox(width: 10),
              FilterButton("Favourite", showFavorites, () {
                setState(() {
                  showFavorites = true;
                  filterContacts();
                });
              }),
            ],
          ),

          // Contact List
          Expanded(
            child: ListView.builder(
              itemCount: displayedContacts.length,
              itemBuilder: (context, index) {
                final contact = displayedContacts[index];
                return Dismissible(
                  key: Key(contact["email"]),
                  background: slideRightBackground(),
                  secondaryBackground: slideLeftBackground(),
                  onDismissed: (direction) {
                    setState(() {
                      allContacts.remove(contact);
                      filterContacts();
                    });
                  },
                  child: ContactTile(contact),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new contact logic
        },
        backgroundColor: Color(0xFF702846),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Contact List Tile Widget
Widget ContactTile(Map<String, dynamic> contact) {
  return ListTile(
    leading: CircleAvatar(backgroundImage: AssetImage(contact["image"])),
    title: Text(contact["name"], style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(contact["email"]),
    trailing: Icon(Icons.send, color: Colors.grey),
  );
}

// Filter Button Widget
Widget FilterButton(String label, bool isActive, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF702846) : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: isActive ? Colors.white : Colors.black),
      ),
    ),
  );
}

// Slide to Delete Background
Widget slideRightBackground() {
  return Container(
    color: Colors.red,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Icon(Icons.delete, color: Colors.white),
  );
}

// Slide to Edit Background
Widget slideLeftBackground() {
  return Container(
    color: Color(0xFF702846),
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Icon(Icons.edit, color: Colors.white),
  );
}

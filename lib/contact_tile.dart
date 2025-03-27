import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'models/contact.dart';
import '../screens/profile_screen.dart'; // Updated import for ProfileScreen

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;
  final Function(Contact) onEdit;

  const ContactTile({
    required this.contact,
    required this.onDelete,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(contact.email),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // ✏️ Edit Button (Dark Maroon)
          SlidableAction(
            onPressed:
                (context) =>
                    _navigateToProfileScreen(context), // Updated function
            backgroundColor: const Color(0xFFC2185B), // Dark Maroon
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: '',
            padding: EdgeInsets.zero,
          ),

          // Divider
          Container(width: 1, color: Colors.white),

          // 🗑️ Delete Button (Dark Maroon)
          SlidableAction(
            onPressed: (context) => _showDeleteConfirmation(context),
            backgroundColor: const Color(0xFFC2185B), // Dark Maroon
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '',
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(contact.imageUrl),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(contact.email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (contact.isFavorite)
              const Icon(Icons.star, color: Colors.orange, size: 20),
            const SizedBox(width: 10),
            const Icon(Icons.send, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _navigateToProfileScreen(BuildContext context) async {
    final updatedContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ProfileScreen(contact: contact), // Navigating to ProfileScreen
      ),
    );

    if (updatedContact != null && updatedContact is Contact) {
      onEdit(updatedContact);
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete Contact"),
            content: const Text(
              "Are you sure you want to delete this contact?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}

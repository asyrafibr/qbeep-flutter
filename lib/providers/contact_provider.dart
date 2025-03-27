import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class ContactProvider extends ChangeNotifier {
  List<Profile> _contacts = [];

  List<Profile> get contacts => _contacts;

  void addContact(Profile profile) {
    _contacts.add(profile);
    notifyListeners();
  }

  void deleteContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  void updateContact(Profile updatedProfile) {
    int index = _contacts.indexWhere(
      (contact) => contact.id == updatedProfile.id,
    );
    if (index != -1) {
      _contacts[index] = updatedProfile;
      notifyListeners();
    }
  }
}

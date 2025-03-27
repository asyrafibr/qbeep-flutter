import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  // Example data
  List<String> _profiles = [];

  List<String> get profiles => _profiles;

  void addProfile(String profile) {
    _profiles.add(profile);
    notifyListeners();
  }
}

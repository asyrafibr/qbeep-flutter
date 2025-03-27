import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';

class ApiService {
  final String baseUrl = "https://your-api.com/profiles";

  Future<List<Profile>> fetchProfiles() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Profile.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load profiles");
    }
  }
}

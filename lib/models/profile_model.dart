class Profile {
  final int id;
  final String name;
  final String phone;
  final bool isFavorite;

  Profile({
    required this.id,
    required this.name,
    required this.phone,
    this.isFavorite = false,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone, 'isFavorite': isFavorite};
  }
}

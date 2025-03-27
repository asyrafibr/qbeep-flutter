class Contact {
  final String name;
  final String email;
  final String imageUrl;
  final bool isFavorite;

  Contact({
    required this.name,
    required this.email,
    required this.imageUrl,
    this.isFavorite = false, // Add default value
  });
}

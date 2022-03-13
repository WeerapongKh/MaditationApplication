class User {
  final String name;
  final String imagePath;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.isDarkMode,
  });

  User copy({
    String? imagePath,
    String? name,
    bool? isDarkMode,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        isDarkMode: json['isDarkMode'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'isDarkMode': isDarkMode,
      };
}

class Program {
  final int id;
  final String? name;

  Program({
    required this.id,
    this.name,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
    );
  }
}

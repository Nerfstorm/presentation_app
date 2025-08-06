class Project {
  final String name;
  final String description;
  final String url;

  Project({
    required this.name,
    required this.description,
    required this.url,
  });

  factory Project.fromJson(Map<String, dynamic> j) => Project(
        name: j['name'] as String,
        description: j['description'] as String,
        url: j['url'] as String,
      );
}

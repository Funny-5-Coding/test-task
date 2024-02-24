class Task {
  final String title;
  final String description;
  bool isCompleted;
  final String category;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.category,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      category: map['category'],
      isCompleted: map['isCompleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted,
    };
  }
}

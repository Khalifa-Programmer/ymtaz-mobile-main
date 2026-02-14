class Course {
  final String id;
  final String title;
  final int totalLessons;
  final bool isCompleted;

  Course({
    required this.id,
    required this.title,
    required this.totalLessons,
    this.isCompleted = false,
  });
} 

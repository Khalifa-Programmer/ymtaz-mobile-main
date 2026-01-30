class FileElement {
  final String? file;
  final String? name;
  final String? type;

  FileElement({
    this.file,
    this.name,
    this.type,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) {
    return FileElement(
      file: json['file'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'name': name,
      'type': type,
    };
  }
}

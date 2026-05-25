class ColumnModel {
  final String id;

  final String title;

  final int order;

  ColumnModel({required this.id, required this.title, required this.order});

  factory ColumnModel.fromJson(Map<String, dynamic> json) {
    return ColumnModel(
      id: json["id"],

      title: json["title"],

      order: json["order"],
    );
  }
}

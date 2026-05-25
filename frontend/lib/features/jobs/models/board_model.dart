import 'column_model.dart';

class BoardModel {
  final String id;

  final String name;

  final List<ColumnModel> columns;

  BoardModel({required this.id, required this.name, required this.columns});

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json["_id"],

      name: json["name"],

      columns: (json["columns"] as List)
          .map((column) => ColumnModel.fromJson(column))
          .toList(),
    );
  }
}

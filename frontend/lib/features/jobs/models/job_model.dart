class JobModel {
  final String id;

  final String company;

  final String position;

  final String status;

  final String location;

  JobModel({
    required this.id,

    required this.company,

    required this.position,

    required this.status,

    required this.location,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json["id"],

      company: json["company"] ?? "",

      position: json["position"] ?? "",

      status: json["status"] ?? "",

      location: json["location"] ?? "",
    );
  }
}

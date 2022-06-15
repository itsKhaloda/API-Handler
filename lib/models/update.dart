class UpdateRequest {
  String name, job;
  UpdateRequest({required this.name, required this.job});
  Map toJson() {
    Map<String, dynamic> json = {"name": this.name, "job": this.job};
    return json;
  }
}

class UpdateResponse {
  String name, job, updatedAt;
  UpdateResponse(
      {required this.name, required this.job, required this.updatedAt});

  factory UpdateResponse.fromJson(Map json) {
    return UpdateResponse(
        name: json['name'], job: json['job'], updatedAt: json['updatedAt']);
  }
}

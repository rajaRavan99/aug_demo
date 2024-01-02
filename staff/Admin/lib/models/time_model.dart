class TimeModel {
  String? id;
  String? reason;
  String? inTime;
  String? outTime;

  TimeModel({this.id, this.reason , this.inTime , this.outTime});

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      id: json.keys.first,
      reason: json.values.first['reason'] ?? '',
      inTime: json.values.first['InTime'] ?? '',
      outTime: json.values.first['OutTime'] ?? '',
    );
  }
}
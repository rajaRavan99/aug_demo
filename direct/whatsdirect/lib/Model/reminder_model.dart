class ReminderModel {
  int? id;
  String name;
  String address;
  String date;
  String time;


  ReminderModel({
    this.id, 
    required this.name, 
    required this.address,
    required this.date,
    required this.time,

  });

  ReminderModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        address = res['address'],
        date = res['date'],
        time = res['time'];


  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'date': date,
      'time': time,

    };
  }
}
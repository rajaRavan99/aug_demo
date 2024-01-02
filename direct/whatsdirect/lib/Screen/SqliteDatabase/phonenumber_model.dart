class TaskData {
  int? id;
  String title;
  String? time;

  TaskData({this.id, required this.title, this.time});

  TaskData.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        time = res['time'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'time': time};
  }
}

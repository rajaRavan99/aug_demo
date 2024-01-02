class Message {
  Message({
    required this.msg,
    required this.formId,
    required this.read,
    required this.told,
    required this.type,
    required this.send,
  });
  late final String msg;
  late final String formId;
  late final String read;
  late final String told;
  late final Type type;
  late final String send;

  Message.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    formId = json['formId'].toString();
    read = json['read'].toString();
    told = json['told'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    send = json['send'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['formId'] = formId;
    data['read'] = read;
    data['told'] = told;
    data['type'] = type.name;
    data['send'] = send;
    return data;
  }
}

enum Type { text, image }

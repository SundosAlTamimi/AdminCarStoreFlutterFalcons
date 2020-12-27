class GeneratingKey {
  String kEY;

  GeneratingKey({this.kEY});

  GeneratingKey.fromJson(Map<String, dynamic> json) {
    kEY = json['KEY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KEY'] = this.kEY;
    return data;
  }
}

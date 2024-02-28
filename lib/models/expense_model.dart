class ExpenseModel {
  String uuid;
  double value;
  String? description;
  DateTime createdOn;

  ExpenseModel({
    required this.uuid,
    required this.value,
    this.description,
    required this.createdOn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'value': value,
      'description': description,
      'createdOn': createdOn.millisecondsSinceEpoch,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      uuid: map['uuid'] as String,
      value: map['value'] as double,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int),
    );
  }
}

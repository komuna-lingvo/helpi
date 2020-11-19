class Contact {
  final int id;
  String name;
  String phoneNumber;
  int buttonId;

  Contact({this.id, this.name, this.phoneNumber, this.buttonId});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'phone_number': this.phoneNumber,
      'button_id': this.buttonId
    };
  }

  static Contact fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      buttonId: json['button_id'],
    );
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, phoneNumber: $phoneNumber, buttonId: $buttonId}';
  }
}

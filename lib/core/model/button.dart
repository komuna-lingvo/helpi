class Button {
  final int id;
  final String title;

  Button({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'title': this.title};
  }

  static Button fromJson(Map<String, dynamic> json) {
    return Button(
      id: json['id'],
      title: json['title'],
    );
  }
}

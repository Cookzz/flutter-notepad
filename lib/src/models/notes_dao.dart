class Notes {
  // Fields
  int id;
  String title;
  String message;

  // Constructor
  Notes({this.id, this.title, this.message});

  // toMap for Sembast storage - sembast stores data as JSON strings
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
    };
  }

  // From map, for sembast storage
  static Notes fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      title: map['title'],
      message: map['message'],
    );
  }
}


import 'dart:convert';

class Todo {
  //final int userId;
  String? id;
  String email;
  String fName;
  String lName;

  Todo({
    this.id,
    required this.email,
    required this.fName,
    required this.lName,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      email: json['email'],
      fName: json['fName'],
      lName: json['lName'],
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      'email' : todo.email,
      'fName' : todo.fName,
      'lName' : todo.lName,
    };
  }
}

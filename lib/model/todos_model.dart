import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodosModel {
  String title;
  String description;
  bool isDone;
  String date;
  String time;

  TodosModel(
      {required this.title,
      required this.description,
      required this.isDone,
      required this.date,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'date': date,
      'time': time,
    };
  }

  factory TodosModel.fromMap(Map<String, dynamic> map) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm');
    return TodosModel(
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      date: map['date'],
      time: map['time'],
    );
  }

  TodosModel copyWith({
    String? title,
    String? description,
    bool? isDone,
    String? date,
    String? time,
  }) {
    return TodosModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}

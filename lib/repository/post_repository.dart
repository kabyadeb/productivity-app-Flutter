import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:productivity/core/snackbar.dart';
import 'package:productivity/model/todos_model.dart';

class PostRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTodo(TodosModel todo, BuildContext context) async {
    try {
      await _firestore.collection('todos').add(todo.toMap());
      showSnackBar(context, 'Todo added successfully');
    } catch (e) {
      log(e.toString());
      showSnackBar(context, 'Failed to add todo');
    }
  }

  Future<List<TodosModel>> getTodos() async {
    List<TodosModel> todos = [];
    try {
      var data = await _firestore.collection('todos').get();

      for (var doc in data.docs) {
        todos.add(TodosModel.fromMap(doc.data()));
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
    return todos;
  }
}

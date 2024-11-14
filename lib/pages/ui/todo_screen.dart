import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:productivity/core/snackbar.dart';
import 'package:productivity/model/todos_model.dart';
import 'package:productivity/repository/post_repository.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  PostRepository _postRepository = PostRepository();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  void onDateSelect() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (_selectedDate != null) {
      selectedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
    }
    setState(() {
      _selectedDate = selectedDate;
      _selectedTime = selectedTime;
    });
  }

  void onAddTodo() async {
    log(_contentController.text);
    if (_contentController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      showSnackBar(context, 'Please fill all the fields');
      return;
    }

    bool result = await InternetConnection().hasInternetAccess;

    if (!result) {
      showSnackBar(context, 'No internet connection');
      return;
    }

    _postRepository.addTodo(
        TodosModel(
            title: _titleController.text,
            description: _contentController.text,
            isDone: false,
            date: _selectedDate!.toString(),
            time: _selectedTime!.toString()),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 1,
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Title',
                  focusColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 6,
              controller: _contentController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Description',
                  focusColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () => onDateSelect(),
                  child: Text(_selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}${_selectedTime == null ? '' : ' Time: ${_selectedTime!.hour}:${_selectedTime!.minute}'}')),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () => onAddTodo(), child: const Text('Add Todo')),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<TodosModel>>(
              future: _postRepository.getTodos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to load todos'),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No todos found'),
                  );
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].description),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

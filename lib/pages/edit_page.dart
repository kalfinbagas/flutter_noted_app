// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:notepad_flutter/data/datasources/local_datasource.dart';
import 'package:notepad_flutter/data/models/noted.dart';
import 'package:notepad_flutter/pages/home_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Note"),
          actions: const [],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Input Title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(
                    fontSize: 16,
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Input Content';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 18,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 2,
                  shadowColor: Colors.grey,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Note note = Note(
                        id: widget.note.id,
                        title: titleController.text,
                        content: contentController.text,
                        createdAt: DateTime.now());
                    LocalDatasource().updateNoteById(note);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  }
                },
                child: Text(
                  "SAVE",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:notepad_flutter/data/datasources/local_datasource.dart';

import 'package:notepad_flutter/data/models/noted.dart';
import 'package:notepad_flutter/pages/edit_page.dart';
import 'package:notepad_flutter/pages/home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Note',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Note'),
                        content: const Text('Are you sure?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                await LocalDatasource()
                                    .deleteNoteById(widget.note.id!);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage();
                                }));
                              },
                              child: const Text('Delete')),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          padding: EdgeInsets.all(10),
          height: double.infinity,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Text(
                  widget.note.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
                height: 20, // Adjust the height of the line as needed
              ),
              const SizedBox(height: 20),
              Text(
                widget.note.content,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPage(
              note: widget.note,
            );
          }));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

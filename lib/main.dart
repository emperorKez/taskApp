// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task App for Shehan'),
        centerTitle: true,
      ),
      body: taskList.isEmpty
          ? const Center(
              child: Text('No Task yet, create a task'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: taskList.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(taskList[index].title),
                    subtitle: Text(taskList[index].description),
                  )),
      floatingActionButton: customFloatingActionButton(),
    );
  }

  Widget customFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet<void>(
          context: context, builder: (context) => addTaskContainer()),
      child: const Icon(Icons.add),
    );
  }

  Widget addTaskContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: titleController,
          keyboardType: TextInputType.text,
          scrollPadding: const EdgeInsets.all(0),
          style: const TextStyle(
            fontSize: 14.0,
          ),
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          minLines: 2,
          maxLines: 4,
          scrollPadding: const EdgeInsets.all(0),
          decoration: const InputDecoration(labelText: 'Description'),
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                final task = Task(
                    title: titleController.text,
                    description: descriptionController.text);
                taskList.add(task);
              });
            },
            child: const Text('Add Task'))
      ],
    );
  }
}

class Task {
  final String title;
  final String description;
  Task({
    required this.title,
    required this.description,
  });
}

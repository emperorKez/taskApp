// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/task_bloc/task_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc() ..add(FetchTask()), lazy: false,
      child: MaterialApp(
        title: 'Task App Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
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
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is TaskLoaded) {
            return state.taskList.isEmpty
                ? const Center(
                    child: Text('No Task yet, create a task'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.taskList.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(state.taskList[index].title),
                          subtitle: Text(state.taskList[index].description),
                        ));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
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
              context.read<TaskBloc>().add(CreateTask(
                  task: Task(
                      title: titleController.text,
                      description: descriptionController.text)));
                      titleController.clear();
                      descriptionController.clear();
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

import 'package:flutter/material.dart';
import 'package:tasko/core/design_system/ui/task_item.dart';

class DashboardTodoScreen extends StatelessWidget {
  const DashboardTodoScreen({super.key});

  List<Widget> get items {
    return [
      TaskItem(
        id: 'TAS-1',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna'
            ' aliqua.',
        createdAt: DateTime(2023, 02, 22, 19),
      ),
      TaskItem(
        id: 'TAS-2',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
        createdAt: DateTime(2023, 02, 20, 19),
      ),
      TaskItem(
        id: 'TAS-3',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna'
            ' aliqua.',
        createdAt: DateTime(2023, 02, 10, 19),
      ),
      TaskItem(
        id: 'TAS-4',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna'
            ' aliqua.',
        createdAt: DateTime(2023, 02, 13, 19),
      ),
      TaskItem(
        id: 'TAS-5',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna',
        createdAt: DateTime(2010, 02, 22, 19),
      ),
      TaskItem(
        id: 'TAS-6',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna'
            ' aliqua.',
        createdAt: DateTime(2023, 01, 22, 19),
      ),
      TaskItem(
        id: 'TAS-7',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna'
            ' aliqua.',
        createdAt: DateTime(2023, 02, 22, 19),
      ),
      TaskItem(
        id: 'TAS-8',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna'
            ' aliqua.',
        createdAt: DateTime(2023, 02, 22, 19),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemBuilder: (context, index) {
          return items[index];
        },
        itemCount: items.length,
      ),
    );
  }
}

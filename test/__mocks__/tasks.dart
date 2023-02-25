import 'package:tasko/data/entities/task.dart';

final getTaskList = [
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
  ),
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
    startedAt: DateTime.now().add(const Duration(minutes: 10)),
  ),
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
    startedAt: DateTime.now().add(const Duration(minutes: 53)),
  ),
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
    startedAt: DateTime.now().add(const Duration(minutes: 34)),
  ),
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
    startedAt: DateTime.now().add(const Duration(minutes: 10)),
    finishedAt: DateTime.now().add(const Duration(minutes: 50)),
  ),
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
    startedAt: DateTime.now().add(const Duration(minutes: 10)),
  ),
  TaskEntity(
    id: 'e1',
    title: 'Lorem ipsum dolor sit amet',
    description: ' consectetur adipiscing elit, sed do eiusmod tempor',
    createdAt: DateTime.now(),
    startedAt: DateTime.now().add(const Duration(minutes: 1)),
    finishedAt: DateTime.now().add(const Duration(minutes: 27)),
  ),
];

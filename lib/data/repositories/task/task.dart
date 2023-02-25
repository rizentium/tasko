import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/repository.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<TaskRepository>()])
class TaskRepository implements Repository {
  final FirebaseDatabase _database;
  final FirebaseAuth _auth;

  TaskRepository({
    required FirebaseDatabase firebaseDatabase,
    required FirebaseAuth firebaseAuth,
  })  : _database = firebaseDatabase,
        _auth = firebaseAuth;

  DatabaseReference _reference({String? ref}) {
    final uid = _auth.currentUser?.uid;
    final path = 'tasks/$uid${ref != null ? '/$ref' : ''}';
    return _database.ref(path)..keepSynced(true);
  }

  List<TaskEntity> _mapping(Map<Object?, Object?> data) {
    return data.entries
        .map((e) => jsonEncode(e.value))
        .map(
          (e) => TaskEntity.fromJson(jsonDecode(e) as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> create(TaskEntity entity) async {
    return await _reference(ref: entity.id).set(entity.toJson());
  }

  Future<List<TaskEntity>> read() async {
    final resource = await _reference().get();

    if (resource.exists) {
      return _mapping(resource.value as Map<Object?, Object?>);
    }
    return [];
  }

  Stream<List<TaskEntity>> asStream() {
    return _reference().onValue.asyncMap(
          (event) => _mapping(event.snapshot.value as Map<Object?, Object?>),
        );
  }

  Future<void> update(TaskEntity entity) async {
    return await _reference(ref: entity.id).update(entity.toJson());
  }

  Future<void> delete(String entityId) async {
    return await _reference().child(entityId).remove();
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerSingleton<TaskRepository>(
      TaskRepository(firebaseDatabase: locator(), firebaseAuth: locator()),
    );
  }
}

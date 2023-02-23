import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/repository.dart';
import 'package:tasko/data/entities/task.dart';

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
    return _database.ref('tasks/$uid/${ref ?? ''}');
  }

  Future<void> create(TaskEntity entity) async {
    return await _reference(ref: entity.id).set(entity);
  }

  Future<List<TaskEntity>> read() async {
    final resource = await _reference().get();

    if (resource.exists) {
      final data = resource.value as Map<String, dynamic>;
      return List.from(data.values).map((e) => TaskEntity.fromJson(e)).toList();
    }
    return [];
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

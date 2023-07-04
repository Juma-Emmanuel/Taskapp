import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Task {
  final int id;
  final String tasktitle;
  final String taskbody;
  bool isChecked;

  Task({
    required this.id,
    required this.tasktitle,
    required this.taskbody,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tasktitle': tasktitle,
      'taskbody': taskbody,
    };
  }
}

class DatabaseHelper {
  static Future<Database> openTasksDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'Tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Tasks(id INTEGER PRIMARY KEY, tasktitle TEXT, taskbody TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTask(Task task) async {
    final db = await openTasksDatabase();
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Task>> getTasks() async {
    final db = await openTasksDatabase();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(
      maps.length,
          (index) {
        return Task(
          id: maps[index]['id'],
          tasktitle: maps[index]['tasktitle'],
          taskbody: maps[index]['taskbody'],

        );
      },
    );
  }

  static Future<void> updateTask(int id, String tasktitle,String taskbody) async {
    final db = await openTasksDatabase();

    await db.update(
      'tasks',
      {'tasktitle': tasktitle,'taskbody': taskbody},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteTask(int id) async {
    final db = await openTasksDatabase();
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
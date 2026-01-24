import 'dart:io';

import 'package:signals/signals.dart';
import 'package:sqlite_async/sqlite3.dart';
import 'package:sqlite_async/sqlite_async.dart';

final migrations = SqliteMigrations()
  ..add(
    SqliteMigration(1, (tx) async {
      await tx.execute(
        '''CREATE TABLE test_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT
      )''',
      );
    }),
  );

typedef TestData = ({int id, String data});
final items = listSignal<TestData>([]);

void main() async {
  final db = SqliteDatabase(path: '${Directory.systemTemp.path}/test.db');
  await migrations.migrate(db);

  final sub = db
      .watchRows(
        'SELECT * FROM test_data',
        triggerOnTables: {'test_data'},
      )
      .map(
        (rows) => rows
            .map(
              (e) => (
                id: e['id'] as int,
                data: e['data'] as String,
              ),
            )
            .toList(),
      )
      .listen((event) => items.value = event);

  final dispose = effect(() {
    print('Items: ${items.value}');
  });

  await db.executeBatch('INSERT INTO test_data(data) values(?)', [
    ['Test1'],
    ['Test2'],
  ]);

  await db.writeTransaction((tx) async {
    await tx.execute('INSERT INTO test_data(data) values(?)', ['Test3']);
    await tx.execute('INSERT INTO test_data(data) values(?)', ['Test4']);
  });

  dispose();
  await sub.cancel();
  await db.close();
}

extension on SqliteDatabase {
  Stream<List<Row>> watchRows(
    String sql, {
    Set<String> triggerOnTables = const {},
    List<Object?> parameters = const [],
  }) async* {
    yield await getAll(sql, parameters);
    final stream = watch(
      sql,
      parameters: parameters,
      triggerOnTables: triggerOnTables.toList(),
    );
    await for (final event in stream) {
      final rows = <Row>[];
      final iterator = event.iterator;
      while (iterator.moveNext()) {
        final row = iterator.current;
        rows.add(row);
      }
      yield rows;
    }
  }
}

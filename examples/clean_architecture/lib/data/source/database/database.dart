import 'package:sqlite_async/sqlite_async.dart';

class Database {
  final String dbPath;
  final Map<int, List<String>> _versions = {};
  late final _database = SqliteDatabase(path: dbPath);

  Database(this.dbPath);

  void addMigration(int version, String sql) {
    _versions.putIfAbsent(version, () => []).add(sql);
  }

  Future<void> init() async {
    await migrate();
  }

  Future<void> migrate() async {
    final migrations = SqliteMigrations();
    for (final entry in _versions.entries) {
      migrations.add(SqliteMigration(entry.key, (tx) async {
        for (final sql in entry.value) {
          await tx.execute(sql);
        }
      }));
    }
    await migrations.migrate(_database);
  }

  Future<void> executeBatch(String sql, List<List<Object?>> params) async {
    await _database.executeBatch(sql, params);
  }

  Future<List<Map<String, Object?>>> execute(
    String sql, {
    List<Object?> params = const [],
  }) async {
    return await _database.execute(sql, params);
  }

  Future<List<Map<String, Object?>>> get(
    String sql, {
    List<Object?> params = const [],
  }) async {
    return await _database.getAll(sql, params);
  }

  Stream<List<Map<String, Object?>>> watch(
    String sql, {
    List<Object?> params = const [],
    List<String>? triggerOnTables,
    Duration throttle = const Duration(milliseconds: 30),
  }) {
    return _database.watch(
      sql,
      parameters: params,
      triggerOnTables: triggerOnTables,
      throttle: throttle,
    );
  }

  Future<Map<String, Object?>> getSingle(
    String sql, {
    List<Object?> params = const [],
  }) async {
    return await _database.get(sql, params);
  }

  Future<Map<String, Object?>?> getSingleOrNull(
    String sql, {
    List<Object?> params = const [],
  }) async {
    return await _database.getOptional(sql, params);
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<int> getLastInsertId() async {
    const sql = 'SELECT last_insert_rowid()';
    final result = await _database.get(sql);
    return result['last_insert_rowid()'] as int;
  }
}

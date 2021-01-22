import 'dart:async';

import 'package:clean_arch_dart_poc/core/database/database_helper.dart';
import 'package:clean_arch_dart_poc/core/database/entity/entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class GenericDatabase<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;
  String get tableName;
  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(tableName, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
    return id;
  }

  Future<List<T>> findAll() {
    return query("SELECT * FROM $tableName");
  }

  Future<T> getPrimary() async {
    List<T> list = await query("""
      SELECT * FROM $tableName
      ORDER BY id DESC LIMIT 1""");
    if (list.length > 0) {
      return list.first;
    }
    return null;
  }

  Future<T> findById(int id) async {
    List<T> list = await query("""
      SELECT * FROM $tableName
      WHERE id = ?
    """, [id]);
    if (list.length > 0) {
      return list.first;
    }
    return null;
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName");
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete("DELETE FROM $tableName WHERE id = ?", [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM $tableName");
  }

  Future<List<T>> query(String sql, [List<dynamic> arguments]) async {
    final dbClient = await db;
    final list = await dbClient.rawQuery(sql, arguments);
    return list.map<T>((json) => fromMap(json)).toList();
  }
}

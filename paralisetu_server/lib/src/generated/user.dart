/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:serverpod/serverpod.dart' as _is;

abstract class ParaliUser
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ParaliUser._({
    this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.passwordHash,
    this.createdAt,
  });

  factory ParaliUser({
    int? id,
    required String email,
    required String name,
    required String role,
    required String passwordHash,
    DateTime? createdAt,
  }) = _ParaliUserImpl;

  factory ParaliUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParaliUser(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String,
      role: jsonSerialization['role'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ParaliUserTable();

  static const db = ParaliUserRepository._();

  @override
  int? id;

  String email;

  String name;

  String role;

  String passwordHash;

  DateTime? createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ParaliUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ParaliUser copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? passwordHash,
    DateTime? createdAt = const _is.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParaliUser',
      if (id != null) 'id': id,
      'email': email,
      'name': name,
      'role': role,
      'passwordHash': passwordHash,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ParaliUser',
      if (id != null) 'id': id,
      'email': email,
      'name': name,
      'role': role,
      'passwordHash': passwordHash,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static ParaliUserInclude include() {
    return ParaliUserInclude._();
  }

  static ParaliUserIncludeList includeList({
    _is.WhereExpressionBuilder<ParaliUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    ParaliUserInclude? include,
  }) {
    return ParaliUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParaliUserImpl extends ParaliUser {
  _ParaliUserImpl({
    int? id,
    required String email,
    required String name,
    required String role,
    required String passwordHash,
    DateTime? createdAt,
  }) : super._(
          id: id,
          email: email,
          name: name,
          role: role,
          passwordHash: passwordHash,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ParaliUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ParaliUser copyWith({
    Object? id = _Undefined,
    String? email,
    String? name,
    String? role,
    String? passwordHash,
    DateTime? createdAt = const _is.$UndefinedDateTime(),
  }) {
    return ParaliUser(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt:
          createdAt is _is.UndefinedSentinel ? this.createdAt : createdAt,
    );
  }
}

class ParaliUserUpdateTable extends _is.UpdateTable<ParaliUserTable> {
  ParaliUserUpdateTable(super.table);

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
        table.email,
        value,
      );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
        table.name,
        value,
      );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
        table.role,
        value,
      );

  _is.ColumnValue<String, String> passwordHash(String value) => _is.ColumnValue(
        table.passwordHash,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ParaliUserTable extends _is.Table<int?> {
  ParaliUserTable({super.tableRelation}) : super(tableName: 'paralisetu_user') {
    updateTable = ParaliUserUpdateTable(this);
    email = _is.ColumnString(
      'email',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    passwordHash = _is.ColumnString(
      'passwordHash',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ParaliUserUpdateTable updateTable;

  late final _is.ColumnString email;

  late final _is.ColumnString name;

  late final _is.ColumnString role;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
        id,
        email,
        name,
        role,
        passwordHash,
        createdAt,
      ];
}

class ParaliUserInclude extends _is.IncludeObject {
  ParaliUserInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ParaliUser.t;
}

class ParaliUserIncludeList extends _is.IncludeList {
  ParaliUserIncludeList._({
    _is.WhereExpressionBuilder<ParaliUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ParaliUser.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ParaliUser.t;
}

class ParaliUserRepository {
  const ParaliUserRepository._();

  /// Returns a list of [ParaliUser]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ParaliUser>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ParaliUser>(
      where: where?.call(ParaliUser.t),
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [ParaliUser]s matching the given query parameters every time the
  /// source tables are modified.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// Use [throttle] to specify the minimum interval between queries. It can
  /// also be set to `null`, in which case the stream will only be throttled
  /// when its subscription is paused.
  ///
  /// Source tables are collected from the queried table, [where], [orderBy],
  /// [orderByList], and the [include] graph. [alsoTriggerOnTables] is added
  /// to that set. Pass [Table] instances such as `ParaliUser.t`.
  ///
  /// Raw [Expression] SQL is not inspected. Tables referenced only in raw
  /// SQL must be passed via [alsoTriggerOnTables].
  ///
  /// The stream always reads committed state and never joins an ambient
  /// [Transaction]. Emissions for a write fire after that write commits.
  ///
  /// Currently only supported on SQLite. Calling this method on PostgreSQL
  /// throws an [UnsupportedError].
  ///
  /// ```dart
  /// var subscription = Persons.db.watch(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// ).listen((persons) {
  ///   // Handle the latest matching rows.
  /// });
  /// ```
  _ida.Stream<List<ParaliUser>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<ParaliUser>(
      where: where?.call(ParaliUser.t),
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [ParaliUser] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ParaliUser?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliUserTable>? where,
    int? offset,
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ParaliUser>(
      where: where?.call(ParaliUser.t),
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ParaliUser] by its [id] or null if no such row exists.
  Future<ParaliUser?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ParaliUser>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ParaliUser]s in the list and returns the inserted rows.
  ///
  /// The returned [ParaliUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliUser>> insert(
    _is.DatabaseSession session,
    List<ParaliUser> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ParaliUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ParaliUser] and returns the inserted row.
  ///
  /// The returned [ParaliUser] will have its `id` field set.
  Future<ParaliUser> insertRow(
    _is.DatabaseSession session,
    ParaliUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ParaliUser>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ParaliUser]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ParaliUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliUser>> upsert(
    _is.DatabaseSession session,
    List<ParaliUser> rows, {
    required _is.ColumnSelections<ParaliUserTable> conflictColumns,
    _is.ColumnSelections<ParaliUserTable>? updateColumns,
    _is.WhereExpressionBuilder<ParaliUserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ParaliUser>(
      rows,
      conflictColumns: conflictColumns(ParaliUser.t),
      updateColumns: updateColumns?.call(ParaliUser.t),
      updateWhere: updateWhere?.call(ParaliUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ParaliUser] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ParaliUser] will have its `id` field set.
  Future<ParaliUser?> upsertRow(
    _is.DatabaseSession session,
    ParaliUser row, {
    required _is.ColumnSelections<ParaliUserTable> conflictColumns,
    _is.ColumnSelections<ParaliUserTable>? updateColumns,
    _is.WhereExpressionBuilder<ParaliUserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ParaliUser>(
      row,
      conflictColumns: conflictColumns(ParaliUser.t),
      updateColumns: updateColumns?.call(ParaliUser.t),
      updateWhere: updateWhere?.call(ParaliUser.t),
      transaction: transaction,
    );
  }

  /// Updates all [ParaliUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliUser>> update(
    _is.DatabaseSession session,
    List<ParaliUser> rows, {
    _is.ColumnSelections<ParaliUserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ParaliUser>(
      rows,
      columns: columns?.call(ParaliUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ParaliUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ParaliUser> updateRow(
    _is.DatabaseSession session,
    ParaliUser row, {
    _is.ColumnSelections<ParaliUserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ParaliUser>(
      row,
      columns: columns?.call(ParaliUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ParaliUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ParaliUser?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ParaliUserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ParaliUser>(
      id,
      columnValues: columnValues(ParaliUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ParaliUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliUser>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ParaliUserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ParaliUserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ParaliUser>(
      columnValues: columnValues(ParaliUser.t.updateTable),
      where: where(ParaliUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ParaliUser]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliUser>> delete(
    _is.DatabaseSession session,
    List<ParaliUser> rows, {
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ParaliUser>(
      rows,
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ParaliUser].
  Future<ParaliUser> deleteRow(
    _is.DatabaseSession session,
    ParaliUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ParaliUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliUser>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParaliUserTable> where,
    _is.OrderByBuilder<ParaliUserTable>? orderBy,
    _is.OrderByListBuilder<ParaliUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ParaliUser>(
      where: where(ParaliUser.t),
      orderBy: orderBy?.call(ParaliUser.t),
      orderByList: orderByList?.call(ParaliUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliUserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ParaliUser>(
      where: where?.call(ParaliUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ParaliUser] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParaliUserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ParaliUser>(
      where: where(ParaliUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

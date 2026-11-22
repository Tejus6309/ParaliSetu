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

abstract class ParaliListing
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ParaliListing._({
    this.id,
    required this.farmerId,
    required this.crop,
    required this.district,
    required this.description,
    required this.availableKg,
    required this.pricePerKg,
    required this.harvestDate,
    required this.availableFrom,
    required this.availableUntil,
    required this.status,
    required this.version,
    this.farmerName,
  });

  factory ParaliListing({
    int? id,
    required int farmerId,
    required String crop,
    required String district,
    required String description,
    required int availableKg,
    required double pricePerKg,
    required DateTime harvestDate,
    required DateTime availableFrom,
    required DateTime availableUntil,
    required String status,
    required int version,
    String? farmerName,
  }) = _ParaliListingImpl;

  factory ParaliListing.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParaliListing(
      id: jsonSerialization['id'] as int?,
      farmerId: jsonSerialization['farmerId'] as int,
      crop: jsonSerialization['crop'] as String,
      district: jsonSerialization['district'] as String,
      description: jsonSerialization['description'] as String,
      availableKg: jsonSerialization['availableKg'] as int,
      pricePerKg: (jsonSerialization['pricePerKg'] as num).toDouble(),
      harvestDate:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['harvestDate']),
      availableFrom: _is.DateTimeJsonExtension.fromJson(
          jsonSerialization['availableFrom']),
      availableUntil: _is.DateTimeJsonExtension.fromJson(
          jsonSerialization['availableUntil']),
      status: jsonSerialization['status'] as String,
      version: jsonSerialization['version'] as int,
      farmerName: jsonSerialization['farmerName'] as String?,
    );
  }

  static final t = ParaliListingTable();

  static const db = ParaliListingRepository._();

  @override
  int? id;

  int farmerId;

  String crop;

  String district;

  String description;

  int availableKg;

  double pricePerKg;

  DateTime harvestDate;

  DateTime availableFrom;

  DateTime availableUntil;

  String status;

  int version;

  String? farmerName;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ParaliListing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ParaliListing copyWith({
    int? id,
    int? farmerId,
    String? crop,
    String? district,
    String? description,
    int? availableKg,
    double? pricePerKg,
    DateTime? harvestDate,
    DateTime? availableFrom,
    DateTime? availableUntil,
    String? status,
    int? version,
    String? farmerName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParaliListing',
      if (id != null) 'id': id,
      'farmerId': farmerId,
      'crop': crop,
      'district': district,
      'description': description,
      'availableKg': availableKg,
      'pricePerKg': pricePerKg,
      'harvestDate': harvestDate.toJson(),
      'availableFrom': availableFrom.toJson(),
      'availableUntil': availableUntil.toJson(),
      'status': status,
      'version': version,
      if (farmerName != null) 'farmerName': farmerName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ParaliListing',
      if (id != null) 'id': id,
      'farmerId': farmerId,
      'crop': crop,
      'district': district,
      'description': description,
      'availableKg': availableKg,
      'pricePerKg': pricePerKg,
      'harvestDate': harvestDate.toJson(),
      'availableFrom': availableFrom.toJson(),
      'availableUntil': availableUntil.toJson(),
      'status': status,
      'version': version,
      if (farmerName != null) 'farmerName': farmerName,
    };
  }

  static ParaliListingInclude include() {
    return ParaliListingInclude._();
  }

  static ParaliListingIncludeList includeList({
    _is.WhereExpressionBuilder<ParaliListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    ParaliListingInclude? include,
  }) {
    return ParaliListingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParaliListingImpl extends ParaliListing {
  _ParaliListingImpl({
    int? id,
    required int farmerId,
    required String crop,
    required String district,
    required String description,
    required int availableKg,
    required double pricePerKg,
    required DateTime harvestDate,
    required DateTime availableFrom,
    required DateTime availableUntil,
    required String status,
    required int version,
    String? farmerName,
  }) : super._(
          id: id,
          farmerId: farmerId,
          crop: crop,
          district: district,
          description: description,
          availableKg: availableKg,
          pricePerKg: pricePerKg,
          harvestDate: harvestDate,
          availableFrom: availableFrom,
          availableUntil: availableUntil,
          status: status,
          version: version,
          farmerName: farmerName,
        );

  /// Returns a shallow copy of this [ParaliListing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ParaliListing copyWith({
    Object? id = _Undefined,
    int? farmerId,
    String? crop,
    String? district,
    String? description,
    int? availableKg,
    double? pricePerKg,
    DateTime? harvestDate,
    DateTime? availableFrom,
    DateTime? availableUntil,
    String? status,
    int? version,
    Object? farmerName = _Undefined,
  }) {
    return ParaliListing(
      id: id is int? ? id : this.id,
      farmerId: farmerId ?? this.farmerId,
      crop: crop ?? this.crop,
      district: district ?? this.district,
      description: description ?? this.description,
      availableKg: availableKg ?? this.availableKg,
      pricePerKg: pricePerKg ?? this.pricePerKg,
      harvestDate: harvestDate ?? this.harvestDate,
      availableFrom: availableFrom ?? this.availableFrom,
      availableUntil: availableUntil ?? this.availableUntil,
      status: status ?? this.status,
      version: version ?? this.version,
      farmerName: farmerName is String? ? farmerName : this.farmerName,
    );
  }
}

class ParaliListingUpdateTable extends _is.UpdateTable<ParaliListingTable> {
  ParaliListingUpdateTable(super.table);

  _is.ColumnValue<int, int> farmerId(int value) => _is.ColumnValue(
        table.farmerId,
        value,
      );

  _is.ColumnValue<String, String> crop(String value) => _is.ColumnValue(
        table.crop,
        value,
      );

  _is.ColumnValue<String, String> district(String value) => _is.ColumnValue(
        table.district,
        value,
      );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
        table.description,
        value,
      );

  _is.ColumnValue<int, int> availableKg(int value) => _is.ColumnValue(
        table.availableKg,
        value,
      );

  _is.ColumnValue<double, double> pricePerKg(double value) => _is.ColumnValue(
        table.pricePerKg,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> harvestDate(DateTime value) =>
      _is.ColumnValue(
        table.harvestDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> availableFrom(DateTime value) =>
      _is.ColumnValue(
        table.availableFrom,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> availableUntil(DateTime value) =>
      _is.ColumnValue(
        table.availableUntil,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
        table.status,
        value,
      );

  _is.ColumnValue<int, int> version(int value) => _is.ColumnValue(
        table.version,
        value,
      );

  _is.ColumnValue<String, String> farmerName(String? value) => _is.ColumnValue(
        table.farmerName,
        value,
      );
}

class ParaliListingTable extends _is.Table<int?> {
  ParaliListingTable({super.tableRelation})
      : super(tableName: 'paralisetu_listing') {
    updateTable = ParaliListingUpdateTable(this);
    farmerId = _is.ColumnInt(
      'farmerId',
      this,
    );
    crop = _is.ColumnString(
      'crop',
      this,
    );
    district = _is.ColumnString(
      'district',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    availableKg = _is.ColumnInt(
      'availableKg',
      this,
    );
    pricePerKg = _is.ColumnDouble(
      'pricePerKg',
      this,
    );
    harvestDate = _is.ColumnDateTime(
      'harvestDate',
      this,
    );
    availableFrom = _is.ColumnDateTime(
      'availableFrom',
      this,
    );
    availableUntil = _is.ColumnDateTime(
      'availableUntil',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    version = _is.ColumnInt(
      'version',
      this,
    );
    farmerName = _is.ColumnString(
      'farmerName',
      this,
    );
  }

  late final ParaliListingUpdateTable updateTable;

  late final _is.ColumnInt farmerId;

  late final _is.ColumnString crop;

  late final _is.ColumnString district;

  late final _is.ColumnString description;

  late final _is.ColumnInt availableKg;

  late final _is.ColumnDouble pricePerKg;

  late final _is.ColumnDateTime harvestDate;

  late final _is.ColumnDateTime availableFrom;

  late final _is.ColumnDateTime availableUntil;

  late final _is.ColumnString status;

  late final _is.ColumnInt version;

  late final _is.ColumnString farmerName;

  @override
  List<_is.Column> get columns => [
        id,
        farmerId,
        crop,
        district,
        description,
        availableKg,
        pricePerKg,
        harvestDate,
        availableFrom,
        availableUntil,
        status,
        version,
        farmerName,
      ];
}

class ParaliListingInclude extends _is.IncludeObject {
  ParaliListingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ParaliListing.t;
}

class ParaliListingIncludeList extends _is.IncludeList {
  ParaliListingIncludeList._({
    _is.WhereExpressionBuilder<ParaliListingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ParaliListing.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ParaliListing.t;
}

class ParaliListingRepository {
  const ParaliListingRepository._();

  /// Returns a list of [ParaliListing]s matching the given query parameters.
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
  Future<List<ParaliListing>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ParaliListing>(
      where: where?.call(ParaliListing.t),
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [ParaliListing]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `ParaliListing.t`.
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
  _ida.Stream<List<ParaliListing>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<ParaliListing>(
      where: where?.call(ParaliListing.t),
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [ParaliListing] matching the given query parameters.
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
  Future<ParaliListing?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliListingTable>? where,
    int? offset,
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ParaliListing>(
      where: where?.call(ParaliListing.t),
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ParaliListing] by its [id] or null if no such row exists.
  Future<ParaliListing?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ParaliListing>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ParaliListing]s in the list and returns the inserted rows.
  ///
  /// The returned [ParaliListing]s will have their `id` fields set.
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
  Future<List<ParaliListing>> insert(
    _is.DatabaseSession session,
    List<ParaliListing> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ParaliListing>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ParaliListing] and returns the inserted row.
  ///
  /// The returned [ParaliListing] will have its `id` field set.
  Future<ParaliListing> insertRow(
    _is.DatabaseSession session,
    ParaliListing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ParaliListing>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ParaliListing]s in the list and returns the resulting rows.
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
  /// The returned [ParaliListing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliListing>> upsert(
    _is.DatabaseSession session,
    List<ParaliListing> rows, {
    required _is.ColumnSelections<ParaliListingTable> conflictColumns,
    _is.ColumnSelections<ParaliListingTable>? updateColumns,
    _is.WhereExpressionBuilder<ParaliListingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ParaliListing>(
      rows,
      conflictColumns: conflictColumns(ParaliListing.t),
      updateColumns: updateColumns?.call(ParaliListing.t),
      updateWhere: updateWhere?.call(ParaliListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ParaliListing] and returns the resulting row.
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
  /// The returned [ParaliListing] will have its `id` field set.
  Future<ParaliListing?> upsertRow(
    _is.DatabaseSession session,
    ParaliListing row, {
    required _is.ColumnSelections<ParaliListingTable> conflictColumns,
    _is.ColumnSelections<ParaliListingTable>? updateColumns,
    _is.WhereExpressionBuilder<ParaliListingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ParaliListing>(
      row,
      conflictColumns: conflictColumns(ParaliListing.t),
      updateColumns: updateColumns?.call(ParaliListing.t),
      updateWhere: updateWhere?.call(ParaliListing.t),
      transaction: transaction,
    );
  }

  /// Updates all [ParaliListing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliListing>> update(
    _is.DatabaseSession session,
    List<ParaliListing> rows, {
    _is.ColumnSelections<ParaliListingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ParaliListing>(
      rows,
      columns: columns?.call(ParaliListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ParaliListing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ParaliListing> updateRow(
    _is.DatabaseSession session,
    ParaliListing row, {
    _is.ColumnSelections<ParaliListingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ParaliListing>(
      row,
      columns: columns?.call(ParaliListing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ParaliListing] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ParaliListing?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ParaliListingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ParaliListing>(
      id,
      columnValues: columnValues(ParaliListing.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ParaliListing]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliListing>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ParaliListingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ParaliListingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ParaliListing>(
      columnValues: columnValues(ParaliListing.t.updateTable),
      where: where(ParaliListing.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ParaliListing]s in the list and returns the deleted rows.
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
  Future<List<ParaliListing>> delete(
    _is.DatabaseSession session,
    List<ParaliListing> rows, {
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ParaliListing>(
      rows,
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ParaliListing].
  Future<ParaliListing> deleteRow(
    _is.DatabaseSession session,
    ParaliListing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ParaliListing>(
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
  Future<List<ParaliListing>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParaliListingTable> where,
    _is.OrderByBuilder<ParaliListingTable>? orderBy,
    _is.OrderByListBuilder<ParaliListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ParaliListing>(
      where: where(ParaliListing.t),
      orderBy: orderBy?.call(ParaliListing.t),
      orderByList: orderByList?.call(ParaliListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliListingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ParaliListing>(
      where: where?.call(ParaliListing.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ParaliListing] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParaliListingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ParaliListing>(
      where: where(ParaliListing.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

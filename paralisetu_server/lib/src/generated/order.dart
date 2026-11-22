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

abstract class ParaliOrder
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ParaliOrder._({
    this.id,
    required this.listingId,
    required this.farmerId,
    required this.buyerId,
    this.carrierId,
    required this.quantityKg,
    required this.pricePerKg,
    required this.crop,
    required this.district,
    required this.status,
    this.farmerArrivedAt,
    this.carrierArrivedAt,
    required this.createdAt,
    this.farmerName,
    this.buyerName,
    this.carrierName,
  });

  factory ParaliOrder({
    int? id,
    required int listingId,
    required int farmerId,
    required int buyerId,
    int? carrierId,
    required int quantityKg,
    required double pricePerKg,
    required String crop,
    required String district,
    required String status,
    DateTime? farmerArrivedAt,
    DateTime? carrierArrivedAt,
    required DateTime createdAt,
    String? farmerName,
    String? buyerName,
    String? carrierName,
  }) = _ParaliOrderImpl;

  factory ParaliOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParaliOrder(
      id: jsonSerialization['id'] as int?,
      listingId: jsonSerialization['listingId'] as int,
      farmerId: jsonSerialization['farmerId'] as int,
      buyerId: jsonSerialization['buyerId'] as int,
      carrierId: jsonSerialization['carrierId'] as int?,
      quantityKg: jsonSerialization['quantityKg'] as int,
      pricePerKg: (jsonSerialization['pricePerKg'] as num).toDouble(),
      crop: jsonSerialization['crop'] as String,
      district: jsonSerialization['district'] as String,
      status: jsonSerialization['status'] as String,
      farmerArrivedAt: jsonSerialization['farmerArrivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['farmerArrivedAt']),
      carrierArrivedAt: jsonSerialization['carrierArrivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['carrierArrivedAt']),
      createdAt:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      farmerName: jsonSerialization['farmerName'] as String?,
      buyerName: jsonSerialization['buyerName'] as String?,
      carrierName: jsonSerialization['carrierName'] as String?,
    );
  }

  static final t = ParaliOrderTable();

  static const db = ParaliOrderRepository._();

  @override
  int? id;

  int listingId;

  int farmerId;

  int buyerId;

  int? carrierId;

  int quantityKg;

  double pricePerKg;

  String crop;

  String district;

  String status;

  DateTime? farmerArrivedAt;

  DateTime? carrierArrivedAt;

  DateTime createdAt;

  String? farmerName;

  String? buyerName;

  String? carrierName;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ParaliOrder]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ParaliOrder copyWith({
    int? id,
    int? listingId,
    int? farmerId,
    int? buyerId,
    int? carrierId,
    int? quantityKg,
    double? pricePerKg,
    String? crop,
    String? district,
    String? status,
    DateTime? farmerArrivedAt = const _is.$UndefinedDateTime(),
    DateTime? carrierArrivedAt = const _is.$UndefinedDateTime(),
    DateTime? createdAt,
    String? farmerName,
    String? buyerName,
    String? carrierName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParaliOrder',
      if (id != null) 'id': id,
      'listingId': listingId,
      'farmerId': farmerId,
      'buyerId': buyerId,
      if (carrierId != null) 'carrierId': carrierId,
      'quantityKg': quantityKg,
      'pricePerKg': pricePerKg,
      'crop': crop,
      'district': district,
      'status': status,
      if (farmerArrivedAt != null) 'farmerArrivedAt': farmerArrivedAt?.toJson(),
      if (carrierArrivedAt != null)
        'carrierArrivedAt': carrierArrivedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (farmerName != null) 'farmerName': farmerName,
      if (buyerName != null) 'buyerName': buyerName,
      if (carrierName != null) 'carrierName': carrierName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ParaliOrder',
      if (id != null) 'id': id,
      'listingId': listingId,
      'farmerId': farmerId,
      'buyerId': buyerId,
      if (carrierId != null) 'carrierId': carrierId,
      'quantityKg': quantityKg,
      'pricePerKg': pricePerKg,
      'crop': crop,
      'district': district,
      'status': status,
      if (farmerArrivedAt != null) 'farmerArrivedAt': farmerArrivedAt?.toJson(),
      if (carrierArrivedAt != null)
        'carrierArrivedAt': carrierArrivedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (farmerName != null) 'farmerName': farmerName,
      if (buyerName != null) 'buyerName': buyerName,
      if (carrierName != null) 'carrierName': carrierName,
    };
  }

  static ParaliOrderInclude include() {
    return ParaliOrderInclude._();
  }

  static ParaliOrderIncludeList includeList({
    _is.WhereExpressionBuilder<ParaliOrderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    ParaliOrderInclude? include,
  }) {
    return ParaliOrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParaliOrderImpl extends ParaliOrder {
  _ParaliOrderImpl({
    int? id,
    required int listingId,
    required int farmerId,
    required int buyerId,
    int? carrierId,
    required int quantityKg,
    required double pricePerKg,
    required String crop,
    required String district,
    required String status,
    DateTime? farmerArrivedAt,
    DateTime? carrierArrivedAt,
    required DateTime createdAt,
    String? farmerName,
    String? buyerName,
    String? carrierName,
  }) : super._(
          id: id,
          listingId: listingId,
          farmerId: farmerId,
          buyerId: buyerId,
          carrierId: carrierId,
          quantityKg: quantityKg,
          pricePerKg: pricePerKg,
          crop: crop,
          district: district,
          status: status,
          farmerArrivedAt: farmerArrivedAt,
          carrierArrivedAt: carrierArrivedAt,
          createdAt: createdAt,
          farmerName: farmerName,
          buyerName: buyerName,
          carrierName: carrierName,
        );

  /// Returns a shallow copy of this [ParaliOrder]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ParaliOrder copyWith({
    Object? id = _Undefined,
    int? listingId,
    int? farmerId,
    int? buyerId,
    Object? carrierId = _Undefined,
    int? quantityKg,
    double? pricePerKg,
    String? crop,
    String? district,
    String? status,
    DateTime? farmerArrivedAt = const _is.$UndefinedDateTime(),
    DateTime? carrierArrivedAt = const _is.$UndefinedDateTime(),
    DateTime? createdAt,
    Object? farmerName = _Undefined,
    Object? buyerName = _Undefined,
    Object? carrierName = _Undefined,
  }) {
    return ParaliOrder(
      id: id is int? ? id : this.id,
      listingId: listingId ?? this.listingId,
      farmerId: farmerId ?? this.farmerId,
      buyerId: buyerId ?? this.buyerId,
      carrierId: carrierId is int? ? carrierId : this.carrierId,
      quantityKg: quantityKg ?? this.quantityKg,
      pricePerKg: pricePerKg ?? this.pricePerKg,
      crop: crop ?? this.crop,
      district: district ?? this.district,
      status: status ?? this.status,
      farmerArrivedAt: farmerArrivedAt is _is.UndefinedSentinel
          ? this.farmerArrivedAt
          : farmerArrivedAt,
      carrierArrivedAt: carrierArrivedAt is _is.UndefinedSentinel
          ? this.carrierArrivedAt
          : carrierArrivedAt,
      createdAt: createdAt ?? this.createdAt,
      farmerName: farmerName is String? ? farmerName : this.farmerName,
      buyerName: buyerName is String? ? buyerName : this.buyerName,
      carrierName: carrierName is String? ? carrierName : this.carrierName,
    );
  }
}

class ParaliOrderUpdateTable extends _is.UpdateTable<ParaliOrderTable> {
  ParaliOrderUpdateTable(super.table);

  _is.ColumnValue<int, int> listingId(int value) => _is.ColumnValue(
        table.listingId,
        value,
      );

  _is.ColumnValue<int, int> farmerId(int value) => _is.ColumnValue(
        table.farmerId,
        value,
      );

  _is.ColumnValue<int, int> buyerId(int value) => _is.ColumnValue(
        table.buyerId,
        value,
      );

  _is.ColumnValue<int, int> carrierId(int? value) => _is.ColumnValue(
        table.carrierId,
        value,
      );

  _is.ColumnValue<int, int> quantityKg(int value) => _is.ColumnValue(
        table.quantityKg,
        value,
      );

  _is.ColumnValue<double, double> pricePerKg(double value) => _is.ColumnValue(
        table.pricePerKg,
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

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
        table.status,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> farmerArrivedAt(DateTime? value) =>
      _is.ColumnValue(
        table.farmerArrivedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> carrierArrivedAt(DateTime? value) =>
      _is.ColumnValue(
        table.carrierArrivedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> farmerName(String? value) => _is.ColumnValue(
        table.farmerName,
        value,
      );

  _is.ColumnValue<String, String> buyerName(String? value) => _is.ColumnValue(
        table.buyerName,
        value,
      );

  _is.ColumnValue<String, String> carrierName(String? value) => _is.ColumnValue(
        table.carrierName,
        value,
      );
}

class ParaliOrderTable extends _is.Table<int?> {
  ParaliOrderTable({super.tableRelation})
      : super(tableName: 'paralisetu_order') {
    updateTable = ParaliOrderUpdateTable(this);
    listingId = _is.ColumnInt(
      'listingId',
      this,
    );
    farmerId = _is.ColumnInt(
      'farmerId',
      this,
    );
    buyerId = _is.ColumnInt(
      'buyerId',
      this,
    );
    carrierId = _is.ColumnInt(
      'carrierId',
      this,
    );
    quantityKg = _is.ColumnInt(
      'quantityKg',
      this,
    );
    pricePerKg = _is.ColumnDouble(
      'pricePerKg',
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
    status = _is.ColumnString(
      'status',
      this,
    );
    farmerArrivedAt = _is.ColumnDateTime(
      'farmerArrivedAt',
      this,
    );
    carrierArrivedAt = _is.ColumnDateTime(
      'carrierArrivedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    farmerName = _is.ColumnString(
      'farmerName',
      this,
    );
    buyerName = _is.ColumnString(
      'buyerName',
      this,
    );
    carrierName = _is.ColumnString(
      'carrierName',
      this,
    );
  }

  late final ParaliOrderUpdateTable updateTable;

  late final _is.ColumnInt listingId;

  late final _is.ColumnInt farmerId;

  late final _is.ColumnInt buyerId;

  late final _is.ColumnInt carrierId;

  late final _is.ColumnInt quantityKg;

  late final _is.ColumnDouble pricePerKg;

  late final _is.ColumnString crop;

  late final _is.ColumnString district;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime farmerArrivedAt;

  late final _is.ColumnDateTime carrierArrivedAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString farmerName;

  late final _is.ColumnString buyerName;

  late final _is.ColumnString carrierName;

  @override
  List<_is.Column> get columns => [
        id,
        listingId,
        farmerId,
        buyerId,
        carrierId,
        quantityKg,
        pricePerKg,
        crop,
        district,
        status,
        farmerArrivedAt,
        carrierArrivedAt,
        createdAt,
        farmerName,
        buyerName,
        carrierName,
      ];
}

class ParaliOrderInclude extends _is.IncludeObject {
  ParaliOrderInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ParaliOrder.t;
}

class ParaliOrderIncludeList extends _is.IncludeList {
  ParaliOrderIncludeList._({
    _is.WhereExpressionBuilder<ParaliOrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ParaliOrder.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ParaliOrder.t;
}

class ParaliOrderRepository {
  const ParaliOrderRepository._();

  /// Returns a list of [ParaliOrder]s matching the given query parameters.
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
  Future<List<ParaliOrder>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliOrderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ParaliOrder>(
      where: where?.call(ParaliOrder.t),
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [ParaliOrder]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `ParaliOrder.t`.
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
  _ida.Stream<List<ParaliOrder>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliOrderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<ParaliOrder>(
      where: where?.call(ParaliOrder.t),
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [ParaliOrder] matching the given query parameters.
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
  Future<ParaliOrder?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliOrderTable>? where,
    int? offset,
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ParaliOrder>(
      where: where?.call(ParaliOrder.t),
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ParaliOrder] by its [id] or null if no such row exists.
  Future<ParaliOrder?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ParaliOrder>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ParaliOrder]s in the list and returns the inserted rows.
  ///
  /// The returned [ParaliOrder]s will have their `id` fields set.
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
  Future<List<ParaliOrder>> insert(
    _is.DatabaseSession session,
    List<ParaliOrder> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ParaliOrder>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ParaliOrder] and returns the inserted row.
  ///
  /// The returned [ParaliOrder] will have its `id` field set.
  Future<ParaliOrder> insertRow(
    _is.DatabaseSession session,
    ParaliOrder row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ParaliOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ParaliOrder]s in the list and returns the resulting rows.
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
  /// The returned [ParaliOrder]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliOrder>> upsert(
    _is.DatabaseSession session,
    List<ParaliOrder> rows, {
    required _is.ColumnSelections<ParaliOrderTable> conflictColumns,
    _is.ColumnSelections<ParaliOrderTable>? updateColumns,
    _is.WhereExpressionBuilder<ParaliOrderTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ParaliOrder>(
      rows,
      conflictColumns: conflictColumns(ParaliOrder.t),
      updateColumns: updateColumns?.call(ParaliOrder.t),
      updateWhere: updateWhere?.call(ParaliOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ParaliOrder] and returns the resulting row.
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
  /// The returned [ParaliOrder] will have its `id` field set.
  Future<ParaliOrder?> upsertRow(
    _is.DatabaseSession session,
    ParaliOrder row, {
    required _is.ColumnSelections<ParaliOrderTable> conflictColumns,
    _is.ColumnSelections<ParaliOrderTable>? updateColumns,
    _is.WhereExpressionBuilder<ParaliOrderTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ParaliOrder>(
      row,
      conflictColumns: conflictColumns(ParaliOrder.t),
      updateColumns: updateColumns?.call(ParaliOrder.t),
      updateWhere: updateWhere?.call(ParaliOrder.t),
      transaction: transaction,
    );
  }

  /// Updates all [ParaliOrder]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliOrder>> update(
    _is.DatabaseSession session,
    List<ParaliOrder> rows, {
    _is.ColumnSelections<ParaliOrderTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ParaliOrder>(
      rows,
      columns: columns?.call(ParaliOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ParaliOrder]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ParaliOrder> updateRow(
    _is.DatabaseSession session,
    ParaliOrder row, {
    _is.ColumnSelections<ParaliOrderTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ParaliOrder>(
      row,
      columns: columns?.call(ParaliOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ParaliOrder] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ParaliOrder?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ParaliOrderUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ParaliOrder>(
      id,
      columnValues: columnValues(ParaliOrder.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ParaliOrder]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParaliOrder>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ParaliOrderUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ParaliOrderTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ParaliOrder>(
      columnValues: columnValues(ParaliOrder.t.updateTable),
      where: where(ParaliOrder.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ParaliOrder]s in the list and returns the deleted rows.
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
  Future<List<ParaliOrder>> delete(
    _is.DatabaseSession session,
    List<ParaliOrder> rows, {
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ParaliOrder>(
      rows,
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ParaliOrder].
  Future<ParaliOrder> deleteRow(
    _is.DatabaseSession session,
    ParaliOrder row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ParaliOrder>(
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
  Future<List<ParaliOrder>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParaliOrderTable> where,
    _is.OrderByBuilder<ParaliOrderTable>? orderBy,
    _is.OrderByListBuilder<ParaliOrderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ParaliOrder>(
      where: where(ParaliOrder.t),
      orderBy: orderBy?.call(ParaliOrder.t),
      orderByList: orderByList?.call(ParaliOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParaliOrderTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ParaliOrder>(
      where: where?.call(ParaliOrder.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ParaliOrder] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParaliOrderTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ParaliOrder>(
      where: where(ParaliOrder.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

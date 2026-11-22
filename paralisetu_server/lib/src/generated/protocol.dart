/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:paralisetu_server/src/generated/listing.dart' as _izd9jiqe;
import 'package:paralisetu_server/src/generated/match_result.dart' as _iodvv7g1;
import 'package:paralisetu_server/src/generated/order.dart' as _irobrff0;
import 'package:paralisetu_server/src/generated/user.dart' as _ipm5u51v;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import 'crop_delivery.dart' as _ir0dk6yr;
import 'impact_stats.dart' as _imo0i0bf;
import 'listing.dart' as _ir9e9w84;
import 'match_result.dart' as _iai9feud;
import 'order.dart' as _ir1ryoer;
import 'pickup_room_view.dart' as _iadmxuya;
import 'user.dart' as _iv73i78m;
export 'crop_delivery.dart';
export 'impact_stats.dart';
export 'listing.dart';
export 'match_result.dart';
export 'order.dart';
export 'pickup_room_view.dart';
export 'user.dart';

class Protocol extends _is.DatabaseSerializationManager
    implements _is.DatabaseProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _is.ProtocolDeserialization get deserializationMetadata =>
      _is.ProtocolDeserialization.cached(
        this,
        types: const [
          _is.getType<_ir0dk6yr.CropDelivery>,
          _is.getType<_imo0i0bf.ImpactStats>,
          _is.getType<_ir9e9w84.ParaliListing>,
          _is.getType<_iai9feud.MatchResult>,
          _is.getType<_ir1ryoer.ParaliOrder>,
          _is.getType<_iadmxuya.PickupRoomView>,
          _is.getType<_iv73i78m.ParaliUser>,
          _is.getType<_ir0dk6yr.CropDelivery?>,
          _is.getType<_imo0i0bf.ImpactStats?>,
          _is.getType<_ir9e9w84.ParaliListing?>,
          _is.getType<_iai9feud.MatchResult?>,
          _is.getType<_ir1ryoer.ParaliOrder?>,
          _is.getType<_iadmxuya.PickupRoomView?>,
          _is.getType<_iv73i78m.ParaliUser?>,
          _is.getType<List<_ir0dk6yr.CropDelivery>>,
          _is.getType<List<String>>,
          _is.getType<List<_iodvv7g1.MatchResult>>,
          _is.getType<List<_izd9jiqe.ParaliListing>>,
          _is.getType<List<_irobrff0.ParaliOrder>>,
          _is.getType<List<_ipm5u51v.ParaliUser>>,
        ],
        modules: const [
          _i1n3uhu0.Protocol.new,
          _isp.Protocol.new,
        ],
        classNames: const [
          'CropDelivery',
          'ImpactStats',
          'ParaliListing',
          'MatchResult',
          'ParaliOrder',
          'PickupRoomView',
          'ParaliUser',
        ],
      );

  static List<_isp.TableDefinition> get targetTableDefinitions => [
        ..._ownTableDefinitions,
        ..._i1n3uhu0.Protocol().getOwnTableDefinitions(),
        ..._isp.Protocol.targetTableDefinitions,
      ];

  static List<_isp.TableDefinition> get _ownTableDefinitions => [
        _isp.TableDefinition(
          name: 'paralisetu_listing',
          dartName: 'ParaliListing',
          schema: 'public',
          module: 'paralisetu',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'farmerId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'crop',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'district',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'description',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'availableKg',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'pricePerKg',
              columnType: _isp.ColumnType.doublePrecision,
              isNullable: false,
              dartType: 'double',
            ),
            _isp.ColumnDefinition(
              name: 'harvestDate',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'availableFrom',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'availableUntil',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'status',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'version',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'farmerName',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
          ],
          foreignKeys: [],
          indexes: [
            _isp.IndexDefinition(
              indexName: 'paralisetu_listing_market_idx',
              tableSpace: null,
              elements: [
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'status',
                ),
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'crop',
                ),
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'district',
                ),
              ],
              type: 'btree',
              isUnique: false,
              isPrimary: false,
            )
          ],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'paralisetu_order',
          dartName: 'ParaliOrder',
          schema: 'public',
          module: 'paralisetu',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'listingId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'farmerId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'buyerId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'carrierId',
              columnType: _isp.ColumnType.bigint,
              isNullable: true,
              dartType: 'int?',
            ),
            _isp.ColumnDefinition(
              name: 'quantityKg',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'pricePerKg',
              columnType: _isp.ColumnType.doublePrecision,
              isNullable: false,
              dartType: 'double',
            ),
            _isp.ColumnDefinition(
              name: 'crop',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'district',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'status',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'farmerArrivedAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: true,
              dartType: 'DateTime?',
            ),
            _isp.ColumnDefinition(
              name: 'carrierArrivedAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: true,
              dartType: 'DateTime?',
            ),
            _isp.ColumnDefinition(
              name: 'createdAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'farmerName',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'buyerName',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'carrierName',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
          ],
          foreignKeys: [],
          indexes: [
            _isp.IndexDefinition(
              indexName: 'paralisetu_order_listing_status_idx',
              tableSpace: null,
              elements: [
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'listingId',
                ),
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'status',
                ),
              ],
              type: 'btree',
              isUnique: false,
              isPrimary: false,
            )
          ],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'paralisetu_user',
          dartName: 'ParaliUser',
          schema: 'public',
          module: 'paralisetu',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'email',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'name',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'role',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'passwordHash',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'createdAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: true,
              dartType: 'DateTime?',
            ),
          ],
          foreignKeys: [],
          indexes: [
            _isp.IndexDefinition(
              indexName: 'paralisetu_user_email_idx',
              tableSpace: null,
              elements: [
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'email',
                )
              ],
              type: 'btree',
              isUnique: true,
              isPrimary: false,
            )
          ],
          managed: true,
        ),
      ];

  static String? getClassNameFromObjectJson(dynamic data) =>
      _is.ProtocolDeserialization.readClassName(data);

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    final rawDataClassName = _is.ProtocolDeserialization.readClassName(data);
    final dataClassName = rawDataClassName;
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ir0dk6yr.CropDelivery) {
      return _ir0dk6yr.CropDelivery.fromJson(data) as T;
    }
    if (t == _imo0i0bf.ImpactStats) {
      return _imo0i0bf.ImpactStats.fromJson(data) as T;
    }
    if (t == _ir9e9w84.ParaliListing) {
      return _ir9e9w84.ParaliListing.fromJson(data) as T;
    }
    if (t == _iai9feud.MatchResult) {
      return _iai9feud.MatchResult.fromJson(data) as T;
    }
    if (t == _ir1ryoer.ParaliOrder) {
      return _ir1ryoer.ParaliOrder.fromJson(data) as T;
    }
    if (t == _iadmxuya.PickupRoomView) {
      return _iadmxuya.PickupRoomView.fromJson(data) as T;
    }
    if (t == _iv73i78m.ParaliUser) {
      return _iv73i78m.ParaliUser.fromJson(data) as T;
    }
    if (t == _is.getType<_ir0dk6yr.CropDelivery?>()) {
      return (data != null ? _ir0dk6yr.CropDelivery.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imo0i0bf.ImpactStats?>()) {
      return (data != null ? _imo0i0bf.ImpactStats.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir9e9w84.ParaliListing?>()) {
      return (data != null ? _ir9e9w84.ParaliListing.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iai9feud.MatchResult?>()) {
      return (data != null ? _iai9feud.MatchResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir1ryoer.ParaliOrder?>()) {
      return (data != null ? _ir1ryoer.ParaliOrder.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iadmxuya.PickupRoomView?>()) {
      return (data != null ? _iadmxuya.PickupRoomView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iv73i78m.ParaliUser?>()) {
      return (data != null ? _iv73i78m.ParaliUser.fromJson(data) : null) as T;
    }
    if (t == List<_ir0dk6yr.CropDelivery>) {
      return (data as List)
          .map((e) => deserialize<_ir0dk6yr.CropDelivery>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iodvv7g1.MatchResult>) {
      return (data as List)
          .map((e) => deserialize<_iodvv7g1.MatchResult>(e))
          .toList() as T;
    }
    if (t == List<_izd9jiqe.ParaliListing>) {
      return (data as List)
          .map((e) => deserialize<_izd9jiqe.ParaliListing>(e))
          .toList() as T;
    }
    if (t == List<_irobrff0.ParaliOrder>) {
      return (data as List)
          .map((e) => deserialize<_irobrff0.ParaliOrder>(e))
          .toList() as T;
    }
    if (t == List<_ipm5u51v.ParaliUser>) {
      return (data as List)
          .map((e) => deserialize<_ipm5u51v.ParaliUser>(e))
          .toList() as T;
    }
    final modules = deserializationMetadata.modulesForDeserialization(
      t,
      className: rawDataClassName,
    );
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _is.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ir0dk6yr.CropDelivery => 'CropDelivery',
      _imo0i0bf.ImpactStats => 'ImpactStats',
      _ir9e9w84.ParaliListing => 'ParaliListing',
      _iai9feud.MatchResult => 'MatchResult',
      _ir1ryoer.ParaliOrder => 'ParaliOrder',
      _iadmxuya.PickupRoomView => 'PickupRoomView',
      _iv73i78m.ParaliUser => 'ParaliUser',
      _ => null
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('paralisetu.', '');
    }

    switch (data) {
      case _ir0dk6yr.CropDelivery():
        return 'CropDelivery';
      case _imo0i0bf.ImpactStats():
        return 'ImpactStats';
      case _ir9e9w84.ParaliListing():
        return 'ParaliListing';
      case _iai9feud.MatchResult():
        return 'MatchResult';
      case _ir1ryoer.ParaliOrder():
        return 'ParaliOrder';
      case _iadmxuya.PickupRoomView():
        return 'PickupRoomView';
      case _iv73i78m.ParaliUser():
        return 'ParaliUser';
    }
    className = _i1n3uhu0.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CropDelivery') {
      return deserialize<_ir0dk6yr.CropDelivery>(data['data']);
    }
    if (dataClassName == 'ImpactStats') {
      return deserialize<_imo0i0bf.ImpactStats>(data['data']);
    }
    if (dataClassName == 'ParaliListing') {
      return deserialize<_ir9e9w84.ParaliListing>(data['data']);
    }
    if (dataClassName == 'MatchResult') {
      return deserialize<_iai9feud.MatchResult>(data['data']);
    }
    if (dataClassName == 'ParaliOrder') {
      return deserialize<_ir1ryoer.ParaliOrder>(data['data']);
    }
    if (dataClassName == 'PickupRoomView') {
      return deserialize<_iadmxuya.PickupRoomView>(data['data']);
    }
    if (dataClassName == 'ParaliUser') {
      return deserialize<_iv73i78m.ParaliUser>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      return _i1n3uhu0.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(15),
      });
    }
    if (dataClassName.startsWith('serverpod.')) {
      return _isp.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(10),
      });
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i1n3uhu0.Protocol().registerHostProtocol('paralisetu', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _i1n3uhu0.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ir9e9w84.ParaliListing:
        return _ir9e9w84.ParaliListing.t;
      case _ir1ryoer.ParaliOrder:
        return _ir1ryoer.ParaliOrder.t;
      case _iv73i78m.ParaliUser:
        return _iv73i78m.ParaliUser.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  List<_isp.TableDefinition> getOwnTableDefinitions() => _ownTableDefinitions;

  @override
  String getModuleName() => 'paralisetu';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i1n3uhu0.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}

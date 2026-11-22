import 'package:serverpod/serverpod.dart' as _i1;
import 'user.dart' as _i2;
import 'listing.dart' as _i3;
import 'order.dart' as _i4;
import 'match_result.dart' as _i5;
import 'impact_stats.dart' as _i6;
import 'pickup_room_view.dart' as _i7;

export 'user.dart';
export 'listing.dart';
export 'order.dart';
export 'match_result.dart';
export 'impact_stats.dart';
export 'pickup_room_view.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  static final Protocol instance = Protocol._();

  static final List<_i1.TableDefinition> targetTableDefinitions = [
    _i1.TableDefinition(
      name: 'paralisetu_user',
      dartName: 'ParaliUser',
      schema: 'public',
      module: 'paralisetu',
      columns: [
        _i1.ColumnDefinition(
          name: 'id',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          hasDefault: true,
        ),
        _i1.ColumnDefinition(
          name: 'email',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'name',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'role',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'passwordHash',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'createdAt',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i1.IndexDefinition(
          indexName: 'paralisetu_user_email_idx',
          tableSpace: null,
          elements: [
            _i1.IndexElementDefinition(
              type: _i1.IndexElementDefinitionType.column,
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
    _i1.TableDefinition(
      name: 'paralisetu_listing',
      dartName: 'ParaliListing',
      schema: 'public',
      module: 'paralisetu',
      columns: [
        _i1.ColumnDefinition(
          name: 'id',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          hasDefault: true,
        ),
        _i1.ColumnDefinition(
          name: 'farmerId',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i1.ColumnDefinition(
          name: 'crop',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'district',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'description',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'availableKg',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i1.ColumnDefinition(
          name: 'pricePerKg',
          columnType: _i1.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i1.ColumnDefinition(
          name: 'harvestDate',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i1.ColumnDefinition(
          name: 'availableFrom',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i1.ColumnDefinition(
          name: 'availableUntil',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i1.ColumnDefinition(
          name: 'status',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'version',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i1.IndexDefinition(
          indexName: 'paralisetu_listing_market_idx',
          tableSpace: null,
          elements: [
            _i1.IndexElementDefinition(
              type: _i1.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i1.IndexElementDefinition(
              type: _i1.IndexElementDefinitionType.column,
              definition: 'crop',
            ),
            _i1.IndexElementDefinition(
              type: _i1.IndexElementDefinitionType.column,
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
    _i1.TableDefinition(
      name: 'paralisetu_order',
      dartName: 'ParaliOrder',
      schema: 'public',
      module: 'paralisetu',
      columns: [
        _i1.ColumnDefinition(
          name: 'id',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          hasDefault: true,
        ),
        _i1.ColumnDefinition(
          name: 'listingId',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i1.ColumnDefinition(
          name: 'farmerId',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i1.ColumnDefinition(
          name: 'buyerId',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i1.ColumnDefinition(
          name: 'carrierId',
          columnType: _i1.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i1.ColumnDefinition(
          name: 'quantityKg',
          columnType: _i1.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i1.ColumnDefinition(
          name: 'pricePerKg',
          columnType: _i1.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i1.ColumnDefinition(
          name: 'crop',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'district',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'status',
          columnType: _i1.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i1.ColumnDefinition(
          name: 'farmerArrivedAt',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i1.ColumnDefinition(
          name: 'carrierArrivedAt',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i1.ColumnDefinition(
          name: 'createdAt',
          columnType: _i1.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i1.IndexDefinition(
          indexName: 'paralisetu_order_listing_status_idx',
          tableSpace: null,
          elements: [
            _i1.IndexElementDefinition(
              type: _i1.IndexElementDefinitionType.column,
              definition: 'listingId',
            ),
            _i1.IndexElementDefinition(
              type: _i1.IndexElementDefinitionType.column,
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
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.ParaliUser) {
      return _i2.ParaliUser.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i3.ParaliListing) {
      return _i3.ParaliListing.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i4.ParaliOrder) {
      return _i4.ParaliOrder.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i5.MatchResult) {
      return _i5.MatchResult.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i6.CropDelivery) {
      return _i6.CropDelivery.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i6.ImpactStats) {
      return _i6.ImpactStats.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i7.PickupRoomView) {
      return _i7.PickupRoomView.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i1.getType<List<_i3.ParaliListing>>()) {
      return (data as List).map((e) => deserialize<_i3.ParaliListing>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i4.ParaliOrder>>()) {
      return (data as List).map((e) => deserialize<_i4.ParaliOrder>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i5.MatchResult>>()) {
      return (data as List).map((e) => deserialize<_i5.MatchResult>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i6.CropDelivery>>()) {
      return (data as List).map((e) => deserialize<_i6.CropDelivery>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i2.ParaliUser>>()) {
      return (data as List).map((e) => deserialize<_i2.ParaliUser>(e)).toList() as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    if (data is _i2.ParaliUser) return 'ParaliUser';
    if (data is _i3.ParaliListing) return 'ParaliListing';
    if (data is _i4.ParaliOrder) return 'ParaliOrder';
    if (data is _i5.MatchResult) return 'MatchResult';
    if (data is _i6.CropDelivery) return 'CropDelivery';
    if (data is _i6.ImpactStats) return 'ImpactStats';
    if (data is _i7.PickupRoomView) return 'PickupRoomView';
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var className = data['className'];
    if (className is! String) {
      return super.deserializeByClassName(data);
    }
    if (className == 'ParaliUser') {
      return deserialize<_i2.ParaliUser>(data['data']);
    }
    if (className == 'ParaliListing') {
      return deserialize<_i3.ParaliListing>(data['data']);
    }
    if (className == 'ParaliOrder') {
      return deserialize<_i4.ParaliOrder>(data['data']);
    }
    if (className == 'MatchResult') {
      return deserialize<_i5.MatchResult>(data['data']);
    }
    if (className == 'CropDelivery') {
      return deserialize<_i6.CropDelivery>(data['data']);
    }
    if (className == 'ImpactStats') {
      return deserialize<_i6.ImpactStats>(data['data']);
    }
    if (className == 'PickupRoomView') {
      return deserialize<_i7.PickupRoomView>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    return null;
  }

  @override
  List<_i1.TableDefinition> getTargetTableDefinitions() => targetTableDefinitions;
}

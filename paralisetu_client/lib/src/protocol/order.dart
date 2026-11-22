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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ParaliOrder
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['farmerArrivedAt']),
      carrierArrivedAt: jsonSerialization['carrierArrivedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['carrierArrivedAt']),
      createdAt:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      farmerName: jsonSerialization['farmerName'] as String?,
      buyerName: jsonSerialization['buyerName'] as String?,
      carrierName: jsonSerialization['carrierName'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [ParaliOrder]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
    DateTime? farmerArrivedAt = const _isc.$UndefinedDateTime(),
    DateTime? carrierArrivedAt = const _isc.$UndefinedDateTime(),
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
    DateTime? farmerArrivedAt = const _isc.$UndefinedDateTime(),
    DateTime? carrierArrivedAt = const _isc.$UndefinedDateTime(),
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
      farmerArrivedAt: farmerArrivedAt is _isc.UndefinedSentinel
          ? this.farmerArrivedAt
          : farmerArrivedAt,
      carrierArrivedAt: carrierArrivedAt is _isc.UndefinedSentinel
          ? this.carrierArrivedAt
          : carrierArrivedAt,
      createdAt: createdAt ?? this.createdAt,
      farmerName: farmerName is String? ? farmerName : this.farmerName,
      buyerName: buyerName is String? ? buyerName : this.buyerName,
      carrierName: carrierName is String? ? carrierName : this.carrierName,
    );
  }
}

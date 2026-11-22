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
import 'package:serverpod/serverpod.dart' as _is;

abstract class PickupRoomView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PickupRoomView._({
    required this.orderId,
    required this.crop,
    required this.district,
    required this.quantityKg,
    required this.farmerName,
    required this.carrierName,
    required this.status,
    this.farmerArrivedAt,
    this.carrierArrivedAt,
  });

  factory PickupRoomView({
    required int orderId,
    required String crop,
    required String district,
    required int quantityKg,
    required String farmerName,
    required String carrierName,
    required String status,
    DateTime? farmerArrivedAt,
    DateTime? carrierArrivedAt,
  }) = _PickupRoomViewImpl;

  factory PickupRoomView.fromJson(Map<String, dynamic> jsonSerialization) {
    return PickupRoomView(
      orderId: jsonSerialization['orderId'] as int,
      crop: jsonSerialization['crop'] as String,
      district: jsonSerialization['district'] as String,
      quantityKg: jsonSerialization['quantityKg'] as int,
      farmerName: jsonSerialization['farmerName'] as String,
      carrierName: jsonSerialization['carrierName'] as String,
      status: jsonSerialization['status'] as String,
      farmerArrivedAt: jsonSerialization['farmerArrivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['farmerArrivedAt']),
      carrierArrivedAt: jsonSerialization['carrierArrivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['carrierArrivedAt']),
    );
  }

  int orderId;

  String crop;

  String district;

  int quantityKg;

  String farmerName;

  String carrierName;

  String status;

  DateTime? farmerArrivedAt;

  DateTime? carrierArrivedAt;

  /// Returns a shallow copy of this [PickupRoomView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PickupRoomView copyWith({
    int? orderId,
    String? crop,
    String? district,
    int? quantityKg,
    String? farmerName,
    String? carrierName,
    String? status,
    DateTime? farmerArrivedAt = const _is.$UndefinedDateTime(),
    DateTime? carrierArrivedAt = const _is.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PickupRoomView',
      'orderId': orderId,
      'crop': crop,
      'district': district,
      'quantityKg': quantityKg,
      'farmerName': farmerName,
      'carrierName': carrierName,
      'status': status,
      if (farmerArrivedAt != null) 'farmerArrivedAt': farmerArrivedAt?.toJson(),
      if (carrierArrivedAt != null)
        'carrierArrivedAt': carrierArrivedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PickupRoomView',
      'orderId': orderId,
      'crop': crop,
      'district': district,
      'quantityKg': quantityKg,
      'farmerName': farmerName,
      'carrierName': carrierName,
      'status': status,
      if (farmerArrivedAt != null) 'farmerArrivedAt': farmerArrivedAt?.toJson(),
      if (carrierArrivedAt != null)
        'carrierArrivedAt': carrierArrivedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PickupRoomViewImpl extends PickupRoomView {
  _PickupRoomViewImpl({
    required int orderId,
    required String crop,
    required String district,
    required int quantityKg,
    required String farmerName,
    required String carrierName,
    required String status,
    DateTime? farmerArrivedAt,
    DateTime? carrierArrivedAt,
  }) : super._(
          orderId: orderId,
          crop: crop,
          district: district,
          quantityKg: quantityKg,
          farmerName: farmerName,
          carrierName: carrierName,
          status: status,
          farmerArrivedAt: farmerArrivedAt,
          carrierArrivedAt: carrierArrivedAt,
        );

  /// Returns a shallow copy of this [PickupRoomView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PickupRoomView copyWith({
    int? orderId,
    String? crop,
    String? district,
    int? quantityKg,
    String? farmerName,
    String? carrierName,
    String? status,
    DateTime? farmerArrivedAt = const _is.$UndefinedDateTime(),
    DateTime? carrierArrivedAt = const _is.$UndefinedDateTime(),
  }) {
    return PickupRoomView(
      orderId: orderId ?? this.orderId,
      crop: crop ?? this.crop,
      district: district ?? this.district,
      quantityKg: quantityKg ?? this.quantityKg,
      farmerName: farmerName ?? this.farmerName,
      carrierName: carrierName ?? this.carrierName,
      status: status ?? this.status,
      farmerArrivedAt: farmerArrivedAt is _is.UndefinedSentinel
          ? this.farmerArrivedAt
          : farmerArrivedAt,
      carrierArrivedAt: carrierArrivedAt is _is.UndefinedSentinel
          ? this.carrierArrivedAt
          : carrierArrivedAt,
    );
  }
}

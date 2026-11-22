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
import 'package:paralisetu_client/src/protocol/protocol.dart' as _ibpb3c0d;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'crop_delivery.dart' as _ir0dk6yr;

abstract class ImpactStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ImpactStats._({
    required this.deliveries,
    required this.deliveredKg,
    required this.estimatedDivertedKg,
    required this.byCrop,
    required this.caveat,
  });

  factory ImpactStats({
    required int deliveries,
    required int deliveredKg,
    required int estimatedDivertedKg,
    required List<_ir0dk6yr.CropDelivery> byCrop,
    required String caveat,
  }) = _ImpactStatsImpl;

  factory ImpactStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImpactStats(
      deliveries: jsonSerialization['deliveries'] as int,
      deliveredKg: jsonSerialization['deliveredKg'] as int,
      estimatedDivertedKg: jsonSerialization['estimatedDivertedKg'] as int,
      byCrop: _ibpb3c0d.Protocol().deserialize<List<_ir0dk6yr.CropDelivery>>(
          jsonSerialization['byCrop']),
      caveat: jsonSerialization['caveat'] as String,
    );
  }

  int deliveries;

  int deliveredKg;

  int estimatedDivertedKg;

  List<_ir0dk6yr.CropDelivery> byCrop;

  String caveat;

  /// Returns a shallow copy of this [ImpactStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ImpactStats copyWith({
    int? deliveries,
    int? deliveredKg,
    int? estimatedDivertedKg,
    List<_ir0dk6yr.CropDelivery>? byCrop,
    String? caveat,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImpactStats',
      'deliveries': deliveries,
      'deliveredKg': deliveredKg,
      'estimatedDivertedKg': estimatedDivertedKg,
      'byCrop': byCrop.toJson(valueToJson: (v) => v.toJson()),
      'caveat': caveat,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ImpactStats',
      'deliveries': deliveries,
      'deliveredKg': deliveredKg,
      'estimatedDivertedKg': estimatedDivertedKg,
      'byCrop': byCrop.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'caveat': caveat,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ImpactStatsImpl extends ImpactStats {
  _ImpactStatsImpl({
    required int deliveries,
    required int deliveredKg,
    required int estimatedDivertedKg,
    required List<_ir0dk6yr.CropDelivery> byCrop,
    required String caveat,
  }) : super._(
          deliveries: deliveries,
          deliveredKg: deliveredKg,
          estimatedDivertedKg: estimatedDivertedKg,
          byCrop: byCrop,
          caveat: caveat,
        );

  /// Returns a shallow copy of this [ImpactStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ImpactStats copyWith({
    int? deliveries,
    int? deliveredKg,
    int? estimatedDivertedKg,
    List<_ir0dk6yr.CropDelivery>? byCrop,
    String? caveat,
  }) {
    return ImpactStats(
      deliveries: deliveries ?? this.deliveries,
      deliveredKg: deliveredKg ?? this.deliveredKg,
      estimatedDivertedKg: estimatedDivertedKg ?? this.estimatedDivertedKg,
      byCrop: byCrop ?? this.byCrop.map((e0) => e0.copyWith()).toList(),
      caveat: caveat ?? this.caveat,
    );
  }
}

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

abstract class ParaliListing
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['harvestDate']),
      availableFrom: _isc.DateTimeJsonExtension.fromJson(
          jsonSerialization['availableFrom']),
      availableUntil: _isc.DateTimeJsonExtension.fromJson(
          jsonSerialization['availableUntil']),
      status: jsonSerialization['status'] as String,
      version: jsonSerialization['version'] as int,
      farmerName: jsonSerialization['farmerName'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [ParaliListing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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

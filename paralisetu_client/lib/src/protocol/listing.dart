import 'package:serverpod_client/serverpod_client.dart';

class ParaliListing extends SerializableModel {
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

  ParaliListing({
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
    this.status = 'ACTIVE',
    this.version = 0,
    this.farmerName,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'farmerId': farmerId,
      'crop': crop,
      'district': district,
      'description': description,
      'availableKg': availableKg,
      'pricePerKg': pricePerKg,
      'harvestDate': harvestDate.toIso8601String(),
      'availableFrom': availableFrom.toIso8601String(),
      'availableUntil': availableUntil.toIso8601String(),
      'status': status,
      'version': version,
      if (farmerName != null) 'farmerName': farmerName,
    };
  }

  factory ParaliListing.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParaliListing(
      id: jsonSerialization['id'] as int?,
      farmerId: jsonSerialization['farmerId'] as int,
      crop: jsonSerialization['crop'] as String,
      district: jsonSerialization['district'] as String,
      description: jsonSerialization['description'] as String,
      availableKg: jsonSerialization['availableKg'] as int,
      pricePerKg: (jsonSerialization['pricePerKg'] as num).toDouble(),
      harvestDate: DateTime.parse(jsonSerialization['harvestDate'] as String),
      availableFrom: DateTime.parse(jsonSerialization['availableFrom'] as String),
      availableUntil: DateTime.parse(jsonSerialization['availableUntil'] as String),
      status: jsonSerialization['status'] as String? ?? 'ACTIVE',
      version: jsonSerialization['version'] as int? ?? 0,
      farmerName: jsonSerialization['farmerName'] as String?,
    );
  }

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
  }) {
    return ParaliListing(
      id: id ?? this.id,
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
      farmerName: farmerName ?? this.farmerName,
    );
  }
}

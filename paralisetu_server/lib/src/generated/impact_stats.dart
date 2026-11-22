import 'package:serverpod/serverpod.dart';

class CropDelivery extends SerializableModel {
  String crop;
  int deliveredKg;

  CropDelivery({
    required this.crop,
    required this.deliveredKg,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'crop': crop,
      'deliveredKg': deliveredKg,
    };
  }

  factory CropDelivery.fromJson(Map<String, dynamic> jsonSerialization) {
    return CropDelivery(
      crop: jsonSerialization['crop'] as String,
      deliveredKg: jsonSerialization['deliveredKg'] as int,
    );
  }
}

class ImpactStats extends SerializableModel {
  int deliveries;
  int deliveredKg;
  int estimatedDivertedKg;
  List<CropDelivery> byCrop;
  String caveat;

  ImpactStats({
    required this.deliveries,
    required this.deliveredKg,
    required this.estimatedDivertedKg,
    required this.byCrop,
    required this.caveat,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'deliveries': deliveries,
      'deliveredKg': deliveredKg,
      'estimatedDivertedKg': estimatedDivertedKg,
      'byCrop': byCrop.map((e) => e.toJson()).toList(),
      'caveat': caveat,
    };
  }

  factory ImpactStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImpactStats(
      deliveries: jsonSerialization['deliveries'] as int,
      deliveredKg: jsonSerialization['deliveredKg'] as int,
      estimatedDivertedKg: jsonSerialization['estimatedDivertedKg'] as int,
      byCrop: (jsonSerialization['byCrop'] as List)
          .map((e) => CropDelivery.fromJson(e as Map<String, dynamic>))
          .toList(),
      caveat: jsonSerialization['caveat'] as String,
    );
  }
}

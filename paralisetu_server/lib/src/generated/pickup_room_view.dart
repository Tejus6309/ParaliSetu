import 'package:serverpod/serverpod.dart';

class PickupRoomView extends SerializableModel {
  int orderId;
  String crop;
  String district;
  int quantityKg;
  String farmerName;
  String carrierName;
  String status;
  DateTime? farmerArrivedAt;
  DateTime? carrierArrivedAt;

  PickupRoomView({
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'crop': crop,
      'district': district,
      'quantityKg': quantityKg,
      'farmerName': farmerName,
      'carrierName': carrierName,
      'status': status,
      if (farmerArrivedAt != null) 'farmerArrivedAt': farmerArrivedAt?.toIso8601String(),
      if (carrierArrivedAt != null) 'carrierArrivedAt': carrierArrivedAt?.toIso8601String(),
    };
  }

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
          : DateTime.parse(jsonSerialization['farmerArrivedAt'] as String),
      carrierArrivedAt: jsonSerialization['carrierArrivedAt'] == null
          ? null
          : DateTime.parse(jsonSerialization['carrierArrivedAt'] as String),
    );
  }
}

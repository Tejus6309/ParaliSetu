import 'package:serverpod_client/serverpod_client.dart';

class ParaliOrder extends SerializableModel {
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

  ParaliOrder({
    this.id,
    required this.listingId,
    required this.farmerId,
    required this.buyerId,
    this.carrierId,
    required this.quantityKg,
    required this.pricePerKg,
    required this.crop,
    required this.district,
    this.status = 'REQUESTED',
    this.farmerArrivedAt,
    this.carrierArrivedAt,
    required this.createdAt,
    this.farmerName,
    this.buyerName,
    this.carrierName,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
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
      if (farmerArrivedAt != null) 'farmerArrivedAt': farmerArrivedAt?.toIso8601String(),
      if (carrierArrivedAt != null) 'carrierArrivedAt': carrierArrivedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (farmerName != null) 'farmerName': farmerName,
      if (buyerName != null) 'buyerName': buyerName,
      if (carrierName != null) 'carrierName': carrierName,
    };
  }

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
      status: jsonSerialization['status'] as String? ?? 'REQUESTED',
      farmerArrivedAt: jsonSerialization['farmerArrivedAt'] == null
          ? null
          : DateTime.parse(jsonSerialization['farmerArrivedAt'] as String),
      carrierArrivedAt: jsonSerialization['carrierArrivedAt'] == null
          ? null
          : DateTime.parse(jsonSerialization['carrierArrivedAt'] as String),
      createdAt: DateTime.parse(jsonSerialization['createdAt'] as String),
      farmerName: jsonSerialization['farmerName'] as String?,
      buyerName: jsonSerialization['buyerName'] as String?,
      carrierName: jsonSerialization['carrierName'] as String?,
    );
  }

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
    DateTime? farmerArrivedAt,
    DateTime? carrierArrivedAt,
    DateTime? createdAt,
    String? farmerName,
    String? buyerName,
    String? carrierName,
  }) {
    return ParaliOrder(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      farmerId: farmerId ?? this.farmerId,
      buyerId: buyerId ?? this.buyerId,
      carrierId: carrierId ?? this.carrierId,
      quantityKg: quantityKg ?? this.quantityKg,
      pricePerKg: pricePerKg ?? this.pricePerKg,
      crop: crop ?? this.crop,
      district: district ?? this.district,
      status: status ?? this.status,
      farmerArrivedAt: farmerArrivedAt ?? this.farmerArrivedAt,
      carrierArrivedAt: carrierArrivedAt ?? this.carrierArrivedAt,
      createdAt: createdAt ?? this.createdAt,
      farmerName: farmerName ?? this.farmerName,
      buyerName: buyerName ?? this.buyerName,
      carrierName: carrierName ?? this.carrierName,
    );
  }
}

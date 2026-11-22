import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'auth_endpoint.dart';

class PickupRoomEndpoint extends Endpoint {
  Future<PickupRoomView> getPickupRoom(
    Session session,
    int userId,
    String userRole,
    int orderId,
  ) async {
    final order = await session.db.findById<ParaliOrder>(orderId);
    if (order == null) {
      throw EndpointException(message: 'Pickup room not found.', errorType: EndpointExceptionType.notFound);
    }

    final isFarmer = userRole == 'FARMER' && order.farmerId == userId;
    final isCarrier = userRole == 'LOGISTICS' && order.carrierId == userId;

    if (!isFarmer && !isCarrier) {
      throw EndpointException(message: 'Pickup room not found.', errorType: EndpointExceptionType.forbidden);
    }

    return PickupRoomView(
      orderId: order.id ?? orderId,
      crop: order.crop,
      district: order.district,
      quantityKg: order.quantityKg,
      farmerName: order.farmerName ?? 'Farmer',
      carrierName: order.carrierName ?? 'Transport Provider',
      status: order.status,
      farmerArrivedAt: order.farmerArrivedAt,
      carrierArrivedAt: order.carrierArrivedAt,
    );
  }

  Future<PickupRoomView> arrive(
    Session session,
    int userId,
    String userRole,
    int orderId,
  ) async {
    final order = await session.db.findById<ParaliOrder>(orderId);
    if (order == null) {
      throw EndpointException(message: 'Pickup room not found.', errorType: EndpointExceptionType.notFound);
    }

    final isFarmer = userRole == 'FARMER' && order.farmerId == userId;
    final isCarrier = userRole == 'LOGISTICS' && order.carrierId == userId;

    if (!isFarmer && !isCarrier) {
      throw EndpointException(message: 'Pickup room not found.', errorType: EndpointExceptionType.forbidden);
    }

    if (order.status != 'ASSIGNED') {
      throw EndpointException(
        message: 'Pickup check-in is closed.',
        errorType: EndpointExceptionType.conflict,
      );
    }

    final now = DateTime.now();
    ParaliOrder updatedOrder;

    if (isFarmer) {
      updatedOrder = order.copyWith(
        farmerArrivedAt: order.farmerArrivedAt ?? now,
      );
    } else {
      updatedOrder = order.copyWith(
        carrierArrivedAt: order.carrierArrivedAt ?? now,
      );
    }

    final saved = await session.db.updateRow<ParaliOrder>(updatedOrder);

    return PickupRoomView(
      orderId: saved.id ?? orderId,
      crop: saved.crop,
      district: saved.district,
      quantityKg: saved.quantityKg,
      farmerName: saved.farmerName ?? 'Farmer',
      carrierName: saved.carrierName ?? 'Transport Provider',
      status: saved.status,
      farmerArrivedAt: saved.farmerArrivedAt,
      carrierArrivedAt: saved.carrierArrivedAt,
    );
  }
}

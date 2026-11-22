import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'auth_endpoint.dart';

class OrderTransition {
  final String status;
  final int reserveSign;
  const OrderTransition(this.status, this.reserveSign);
}

class OrdersEndpoint extends Endpoint {
  static OrderTransition transition(String role, String status, String action) {
    final key = '$role:$status:$action';
    switch (key) {
      case 'FARMER:REQUESTED:ACCEPT':
        return const OrderTransition('ACCEPTED', 1);
      case 'FARMER:REQUESTED:REJECT':
        return const OrderTransition('REJECTED', 0);
      case 'BUYER:REQUESTED:CANCEL':
        return const OrderTransition('CANCELLED', 0);
      case 'BUYER:ACCEPTED:CANCEL':
      case 'BUYER:ASSIGNED:CANCEL':
      case 'FARMER:ACCEPTED:CANCEL':
      case 'FARMER:ASSIGNED:CANCEL':
        return const OrderTransition('CANCELLED', -1);
      case 'FARMER:ACCEPTED:ASSIGN':
        return const OrderTransition('ASSIGNED', 0);
      case 'LOGISTICS:ASSIGNED:PICK_UP':
        return const OrderTransition('PICKED_UP', 0);
      case 'LOGISTICS:PICKED_UP:DELIVER':
        return const OrderTransition('DELIVERED', 0);
      default:
        throw EndpointException(
          message: 'That action is unavailable for this order status and role.',
          errorType: EndpointExceptionType.conflict,
        );
    }
  }

  Future<List<ParaliOrder>> getOrders(Session session, int userId, String userRole) async {
    switch (userRole) {
      case 'FARMER':
        return await session.db.find<ParaliOrder>(
          where: (t) => t.farmerId.equals(userId),
          orderBy: (t) => t.id,
          orderDescending: true,
        );
      case 'BUYER':
        return await session.db.find<ParaliOrder>(
          where: (t) => t.buyerId.equals(userId),
          orderBy: (t) => t.id,
          orderDescending: true,
        );
      case 'LOGISTICS':
        return await session.db.find<ParaliOrder>(
          where: (t) => t.carrierId.equals(userId),
          orderBy: (t) => t.id,
          orderDescending: true,
        );
      case 'ADMIN':
        return await session.db.find<ParaliOrder>(
          orderBy: (t) => t.id,
          orderDescending: true,
        );
      default:
        return [];
    }
  }

  Future<List<ParaliUser>> getCarriers(Session session) async {
    final users = await session.db.find<ParaliUser>(
      where: (t) => t.role.equals('LOGISTICS'),
      orderBy: (t) => t.name,
    );
    return users.map((u) => u.copyWith(passwordHash: '')).toList();
  }

  Future<ParaliOrder> requestOrder(
    Session session, {
    required int buyerId,
    required String buyerName,
    required int listingId,
    required int quantityKg,
  }) async {
    if (quantityKg <= 0) {
      throw EndpointException(message: 'Quantity must be positive.', errorType: EndpointExceptionType.badRequest);
    }

    final listing = await session.db.findById<ParaliListing>(listingId);
    if (listing == null || listing.status != 'ACTIVE') {
      throw EndpointException(message: 'Listing not available.', errorType: EndpointExceptionType.conflict);
    }

    if (listing.availableKg < quantityKg) {
      throw EndpointException(
        message: 'This active listing does not have enough available stock.',
        errorType: EndpointExceptionType.conflict,
      );
    }

    final order = ParaliOrder(
      listingId: listingId,
      farmerId: listing.farmerId,
      buyerId: buyerId,
      quantityKg: quantityKg,
      pricePerKg: listing.pricePerKg,
      crop: listing.crop,
      district: listing.district,
      status: 'REQUESTED',
      farmerName: listing.farmerName,
      buyerName: buyerName,
      createdAt: DateTime.now(),
    );

    return await session.db.insertRow<ParaliOrder>(order);
  }

  Future<ParaliOrder> changeOrder(
    Session session, {
    required int userId,
    required String userRole,
    required int orderId,
    required String action,
    int? carrierId,
  }) async {
    final order = await session.db.findById<ParaliOrder>(orderId);
    if (order == null) {
      throw EndpointException(message: 'Order not found.', errorType: EndpointExceptionType.notFound);
    }

    // Role membership verification
    if (userRole == 'FARMER' && order.farmerId != userId) {
      throw EndpointException(message: 'Not authorized for this order.', errorType: EndpointExceptionType.forbidden);
    }
    if (userRole == 'BUYER' && order.buyerId != userId) {
      throw EndpointException(message: 'Not authorized for this order.', errorType: EndpointExceptionType.forbidden);
    }
    if (userRole == 'LOGISTICS' && order.carrierId != userId) {
      throw EndpointException(message: 'Not authorized for this order.', errorType: EndpointExceptionType.forbidden);
    }

    final trans = transition(userRole, order.status, action);

    final listing = await session.db.findById<ParaliListing>(order.listingId);
    if (listing == null) {
      throw EndpointException(message: 'Associated listing not found.', errorType: EndpointExceptionType.notFound);
    }

    String? carrierName = order.carrierName;
    if (action == 'ASSIGN') {
      if (carrierId == null) {
        throw EndpointException(message: 'Select an existing logistics provider.', errorType: EndpointExceptionType.badRequest);
      }
      final carrier = await session.db.findById<ParaliUser>(carrierId);
      if (carrier == null || carrier.role != 'LOGISTICS') {
        throw EndpointException(message: 'Select an existing logistics provider.', errorType: EndpointExceptionType.badRequest);
      }
      carrierName = carrier.name;
    }

    // Stock reservations
    if (trans.reserveSign == 1) {
      if (listing.status != 'ACTIVE' || listing.availableKg < order.quantityKg) {
        throw EndpointException(
          message: 'Stock terms changed. Reject the request and ask the buyer to submit again.',
          errorType: EndpointExceptionType.conflict,
        );
      }
      await session.db.updateRow<ParaliListing>(listing.copyWith(
        availableKg: listing.availableKg - order.quantityKg,
        version: listing.version + 1,
      ));
    } else if (trans.reserveSign == -1) {
      await session.db.updateRow<ParaliListing>(listing.copyWith(
        availableKg: listing.availableKg + order.quantityKg,
        version: listing.version + 1,
      ));
    }

    final updatedOrder = order.copyWith(
      status: trans.status,
      carrierId: action == 'ASSIGN' ? carrierId : order.carrierId,
      carrierName: carrierName,
    );

    return await session.db.updateRow<ParaliOrder>(updatedOrder);
  }
}

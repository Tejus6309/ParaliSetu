
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class OrderTransition {
  final String status;
  final int reserveSign;

  const OrderTransition(this.status, this.reserveSign);
}

class OrdersEndpoint extends Endpoint {
  static OrderTransition transition(
    String role,
    String status,
    String action,
  ) {
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
        throw Exception(
          'Action unavailable for this role and order status.',
        );
    }
  }

  // Get orders according to user role.
  Future<List<ParaliOrder>> getOrders(
    Session session,
    int userId,
    String userRole,
  ) async {
    switch (userRole) {
      case 'FARMER':
        return await ParaliOrder.db.find(
          session,
          where: (t) => t.farmerId.equals(userId),
          orderBy: (t) => t.id,
        );

      case 'BUYER':
        return await ParaliOrder.db.find(
          session,
          where: (t) => t.buyerId.equals(userId),
          orderBy: (t) => t.id,
        );

      case 'LOGISTICS':
        return await ParaliOrder.db.find(
          session,
          where: (t) => t.carrierId.equals(userId),
          orderBy: (t) => t.id,
        );

      case 'ADMIN':
        return await ParaliOrder.db.find(
          session,
          orderBy: (t) => t.id,
        );

      default:
        return [];
    }
  }

  // Get logistics providers.
  Future<List<ParaliUser>> getCarriers(
    Session session,
  ) async {
    final users = await ParaliUser.db.find(
      session,
      where: (t) => t.role.equals('LOGISTICS'),
      orderBy: (t) => t.name,
    );

    return users
        .map((user) => user.copyWith(passwordHash: ''))
        .toList();
  }

  // Create purchase request.
  Future<ParaliOrder> requestOrder(
    Session session, {
    required int buyerId,
    required String buyerName,
    required int listingId,
    required int quantityKg,
  }) async {
    if (quantityKg <= 0) {
      throw Exception('Quantity must be positive.');
    }

    final listing = await ParaliListing.db.findById(
      session,
      listingId,
    );

    if (listing == null || listing.status != 'ACTIVE') {
      throw Exception('Listing not available.');
    }

    if (listing.availableKg < quantityKg) {
      throw Exception('Not enough available stock.');
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

    return await ParaliOrder.db.insertRow(
      session,
      order,
    );
  }

  // Change order status.
  Future<ParaliOrder> changeOrder(
    Session session, {
    required int userId,
    required String userRole,
    required int orderId,
    required String action,
    int? carrierId,
  }) async {
    final order = await ParaliOrder.db.findById(
      session,
      orderId,
    );

    if (order == null) {
      throw Exception('Order not found.');
    }

    // Verify ownership.
    if (userRole == 'FARMER' && order.farmerId != userId) {
      throw Exception('Not authorized for this order.');
    }

    if (userRole == 'BUYER' && order.buyerId != userId) {
      throw Exception('Not authorized for this order.');
    }

    if (userRole == 'LOGISTICS' && order.carrierId != userId) {
      throw Exception('Not authorized for this order.');
    }

    final trans = transition(
      userRole,
      order.status,
      action,
    );

    final listing = await ParaliListing.db.findById(
      session,
      order.listingId,
    );

    if (listing == null) {
      throw Exception('Associated listing not found.');
    }

    String? carrierName = order.carrierName;

    // Assign logistics provider.
    if (action == 'ASSIGN') {
      if (carrierId == null) {
        throw Exception('Select a logistics provider.');
      }

      final carrier = await ParaliUser.db.findById(
        session,
        carrierId,
      );

      if (carrier == null || carrier.role != 'LOGISTICS') {
        throw Exception('Invalid logistics provider.');
      }

      carrierName = carrier.name;
    }

    // Reserve stock.
    if (trans.reserveSign == 1) {
      if (listing.status != 'ACTIVE' ||
          listing.availableKg < order.quantityKg) {
        throw Exception('Insufficient available stock.');
      }

      await ParaliListing.db.updateRow(
        session,
        listing.copyWith(
          availableKg: listing.availableKg - order.quantityKg,
          version: listing.version + 1,
        ),
      );
    }

    // Restore stock after cancellation.
    if (trans.reserveSign == -1) {
      await ParaliListing.db.updateRow(
        session,
        listing.copyWith(
          availableKg: listing.availableKg + order.quantityKg,
          version: listing.version + 1,
        ),
      );
    }

    final updatedOrder = order.copyWith(
      status: trans.status,
      carrierId: action == 'ASSIGN'
          ? carrierId
          : order.carrierId,
      carrierName: carrierName,
    );

    return await ParaliOrder.db.updateRow(
      session,
      updatedOrder,
    );
  }
}

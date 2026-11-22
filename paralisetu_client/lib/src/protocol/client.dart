import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  Future<_i2.ParaliUser?> login(String email, String password) =>
      caller.callServerEndpoint<_i2.ParaliUser?>('auth', 'login', {
        'email': email,
        'password': password,
      });

  Future<_i2.ParaliUser> register(String name, String email, String password, String role) =>
      caller.callServerEndpoint<_i2.ParaliUser>('auth', 'register', {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      });

  Future<_i2.ParaliUser?> me(int userId) =>
      caller.callServerEndpoint<_i2.ParaliUser?>('auth', 'me', {
        'userId': userId,
      });
}

class EndpointListings extends _i1.EndpointRef {
  EndpointListings(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listings';

  Future<List<_i2.ParaliListing>> browse({
    String? q,
    String? crop,
    String? district,
    int minKg = 1,
    int offset = 0,
    DateTime? harvestAfter,
  }) =>
      caller.callServerEndpoint<List<_i2.ParaliListing>>('listings', 'browse', {
        'q': q,
        'crop': crop,
        'district': district,
        'minKg': minKg,
        'offset': offset,
        'harvestAfter': harvestAfter,
      });

  Future<_i2.ParaliListing> detail(int id, {int? viewerUserId, String? viewerRole}) =>
      caller.callServerEndpoint<_i2.ParaliListing>('listings', 'detail', {
        'id': id,
        'viewerUserId': viewerUserId,
        'viewerRole': viewerRole,
      });

  Future<List<_i2.ParaliListing>> farmerListings(int farmerId) =>
      caller.callServerEndpoint<List<_i2.ParaliListing>>('listings', 'farmerListings', {
        'farmerId': farmerId,
      });

  Future<_i2.ParaliListing> create({
    required int farmerId,
    required String farmerName,
    required String crop,
    required String district,
    required String description,
    required int availableKg,
    required double pricePerKg,
    required DateTime harvestDate,
    required DateTime availableFrom,
    required DateTime availableUntil,
  }) =>
      caller.callServerEndpoint<_i2.ParaliListing>('listings', 'create', {
        'farmerId': farmerId,
        'farmerName': farmerName,
        'crop': crop,
        'district': district,
        'description': description,
        'availableKg': availableKg,
        'pricePerKg': pricePerKg,
        'harvestDate': harvestDate,
        'availableFrom': availableFrom,
        'availableUntil': availableUntil,
      });

  Future<_i2.ParaliListing> edit({
    required int farmerId,
    required int id,
    required int version,
    required String crop,
    required String district,
    required String description,
    required int availableKg,
    required double pricePerKg,
    required DateTime harvestDate,
    required DateTime availableFrom,
    required DateTime availableUntil,
  }) =>
      caller.callServerEndpoint<_i2.ParaliListing>('listings', 'edit', {
        'farmerId': farmerId,
        'id': id,
        'version': version,
        'crop': crop,
        'district': district,
        'description': description,
        'availableKg': availableKg,
        'pricePerKg': pricePerKg,
        'harvestDate': harvestDate,
        'availableFrom': availableFrom,
        'availableUntil': availableUntil,
      });

  Future<void> status(int farmerId, int id, String newStatus) =>
      caller.callServerEndpoint<void>('listings', 'status', {
        'farmerId': farmerId,
        'id': id,
        'newStatus': newStatus,
      });

  Future<void> delete(int farmerId, int id) =>
      caller.callServerEndpoint<void>('listings', 'delete', {
        'farmerId': farmerId,
        'id': id,
      });

  Future<List<_i2.ParaliListing>> adminListings() =>
      caller.callServerEndpoint<List<_i2.ParaliListing>>('listings', 'adminListings', {});

  Future<void> moderate(int id, String newStatus) =>
      caller.callServerEndpoint<void>('listings', 'moderate', {
        'id': id,
        'newStatus': newStatus,
      });
}

class EndpointOrders extends _i1.EndpointRef {
  EndpointOrders(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'orders';

  Future<List<_i2.ParaliOrder>> getOrders(int userId, String userRole) =>
      caller.callServerEndpoint<List<_i2.ParaliOrder>>('orders', 'getOrders', {
        'userId': userId,
        'userRole': userRole,
      });

  Future<List<_i2.ParaliUser>> getCarriers() =>
      caller.callServerEndpoint<List<_i2.ParaliUser>>('orders', 'getCarriers', {});

  Future<_i2.ParaliOrder> requestOrder({
    required int buyerId,
    required String buyerName,
    required int listingId,
    required int quantityKg,
  }) =>
      caller.callServerEndpoint<_i2.ParaliOrder>('orders', 'requestOrder', {
        'buyerId': buyerId,
        'buyerName': buyerName,
        'listingId': listingId,
        'quantityKg': quantityKg,
      });

  Future<_i2.ParaliOrder> changeOrder({
    required int userId,
    required String userRole,
    required int orderId,
    required String action,
    int? carrierId,
  }) =>
      caller.callServerEndpoint<_i2.ParaliOrder>('orders', 'changeOrder', {
        'userId': userId,
        'userRole': userRole,
        'orderId': orderId,
        'action': action,
        'carrierId': carrierId,
      });
}

class EndpointPickupRoom extends _i1.EndpointRef {
  EndpointPickupRoom(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pickupRoom';

  Future<_i2.PickupRoomView> getPickupRoom(int userId, String userRole, int orderId) =>
      caller.callServerEndpoint<_i2.PickupRoomView>('pickupRoom', 'getPickupRoom', {
        'userId': userId,
        'userRole': userRole,
        'orderId': orderId,
      });

  Future<_i2.PickupRoomView> arrive(int userId, String userRole, int orderId) =>
      caller.callServerEndpoint<_i2.PickupRoomView>('pickupRoom', 'arrive', {
        'userId': userId,
        'userRole': userRole,
        'orderId': orderId,
      });
}

class EndpointInsights extends _i1.EndpointRef {
  EndpointInsights(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'insights';

  Future<List<_i2.MatchResult>> matches({
    required String crop,
    required String district,
    required int quantityKg,
    double? maxPrice,
  }) =>
      caller.callServerEndpoint<List<_i2.MatchResult>>('insights', 'matches', {
        'crop': crop,
        'district': district,
        'quantityKg': quantityKg,
        'maxPrice': maxPrice,
      });

  Future<_i2.ImpactStats> impact() =>
      caller.callServerEndpoint<_i2.ImpactStats>('insights', 'impact', {});
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i2.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    auth = EndpointAuth(this);
    listings = EndpointListings(this);
    orders = EndpointOrders(this);
    pickupRoom = EndpointPickupRoom(this);
    insights = EndpointInsights(this);
  }

  late final EndpointAuth auth;
  late final EndpointListings listings;
  late final EndpointOrders orders;
  late final EndpointPickupRoom pickupRoom;
  late final EndpointInsights insights;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'listings': listings,
        'orders': orders,
        'pickupRoom': pickupRoom,
        'insights': insights,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}

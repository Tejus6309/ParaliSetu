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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:paralisetu_client/src/protocol/impact_stats.dart' as _ia3tdhrn;
import 'package:paralisetu_client/src/protocol/listing.dart' as _ire2x1fo;
import 'package:paralisetu_client/src/protocol/match_result.dart' as _ir2pm0go;
import 'package:paralisetu_client/src/protocol/order.dart' as _iodp2z1e;
import 'package:paralisetu_client/src/protocol/pickup_room_view.dart'
    as _in7cqc6m;
import 'package:paralisetu_client/src/protocol/user.dart' as _i1jvt56g;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i312scxx;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAuth extends _isc.EndpointRef {
  EndpointAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _ida.Future<_i1jvt56g.ParaliUser?> login(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<_i1jvt56g.ParaliUser?>(
        'auth',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  _ida.Future<_i1jvt56g.ParaliUser> register(
    String name,
    String email,
    String password,
    String role,
  ) =>
      caller.callServerEndpoint<_i1jvt56g.ParaliUser>(
        'auth',
        'register',
        {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      );

  _ida.Future<_i1jvt56g.ParaliUser?> me(int userId) =>
      caller.callServerEndpoint<_i1jvt56g.ParaliUser?>(
        'auth',
        'me',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointInsights extends _isc.EndpointRef {
  EndpointInsights(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'insights';

  _ida.Future<List<_ir2pm0go.MatchResult>> matches({
    required String crop,
    required String district,
    required int quantityKg,
    double? maxPrice,
  }) =>
      caller.callServerEndpoint<List<_ir2pm0go.MatchResult>>(
        'insights',
        'matches',
        {
          'crop': crop,
          'district': district,
          'quantityKg': quantityKg,
          'maxPrice': maxPrice,
        },
      );

  _ida.Future<_ia3tdhrn.ImpactStats> impact() =>
      caller.callServerEndpoint<_ia3tdhrn.ImpactStats>(
        'insights',
        'impact',
        {},
      );
}

/// {@category Endpoint}
class EndpointListings extends _isc.EndpointRef {
  EndpointListings(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listings';

  _ida.Future<List<_ire2x1fo.ParaliListing>> browse({
    String? q,
    String? crop,
    String? district,
    required int minKg,
    required int offset,
    DateTime? harvestAfter,
  }) =>
      caller.callServerEndpoint<List<_ire2x1fo.ParaliListing>>(
        'listings',
        'browse',
        {
          'q': q,
          'crop': crop,
          'district': district,
          'minKg': minKg,
          'offset': offset,
          'harvestAfter': harvestAfter,
        },
      );

  _ida.Future<_ire2x1fo.ParaliListing> detail(
    int id, {
    int? viewerUserId,
    String? viewerRole,
  }) =>
      caller.callServerEndpoint<_ire2x1fo.ParaliListing>(
        'listings',
        'detail',
        {
          'id': id,
          'viewerUserId': viewerUserId,
          'viewerRole': viewerRole,
        },
      );

  _ida.Future<List<_ire2x1fo.ParaliListing>> farmerListings(int farmerId) =>
      caller.callServerEndpoint<List<_ire2x1fo.ParaliListing>>(
        'listings',
        'farmerListings',
        {'farmerId': farmerId},
      );

  _ida.Future<_ire2x1fo.ParaliListing> create({
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
      caller.callServerEndpoint<_ire2x1fo.ParaliListing>(
        'listings',
        'create',
        {
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
        },
      );

  _ida.Future<_ire2x1fo.ParaliListing> edit({
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
      caller.callServerEndpoint<_ire2x1fo.ParaliListing>(
        'listings',
        'edit',
        {
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
        },
      );

  _ida.Future<void> status(
    int farmerId,
    int id,
    String newStatus,
  ) =>
      caller.callServerEndpoint<void>(
        'listings',
        'status',
        {
          'farmerId': farmerId,
          'id': id,
          'newStatus': newStatus,
        },
      );

  _ida.Future<void> delete(
    int farmerId,
    int id,
  ) =>
      caller.callServerEndpoint<void>(
        'listings',
        'delete',
        {
          'farmerId': farmerId,
          'id': id,
        },
      );

  _ida.Future<List<_ire2x1fo.ParaliListing>> adminListings() =>
      caller.callServerEndpoint<List<_ire2x1fo.ParaliListing>>(
        'listings',
        'adminListings',
        {},
      );

  _ida.Future<void> moderate(
    int id,
    String newStatus,
  ) =>
      caller.callServerEndpoint<void>(
        'listings',
        'moderate',
        {
          'id': id,
          'newStatus': newStatus,
        },
      );
}

/// {@category Endpoint}
class EndpointOrders extends _isc.EndpointRef {
  EndpointOrders(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'orders';

  _ida.Future<List<_iodp2z1e.ParaliOrder>> getOrders(
    int userId,
    String userRole,
  ) =>
      caller.callServerEndpoint<List<_iodp2z1e.ParaliOrder>>(
        'orders',
        'getOrders',
        {
          'userId': userId,
          'userRole': userRole,
        },
      );

  _ida.Future<List<_i1jvt56g.ParaliUser>> getCarriers() =>
      caller.callServerEndpoint<List<_i1jvt56g.ParaliUser>>(
        'orders',
        'getCarriers',
        {},
      );

  _ida.Future<_iodp2z1e.ParaliOrder> requestOrder({
    required int buyerId,
    required String buyerName,
    required int listingId,
    required int quantityKg,
  }) =>
      caller.callServerEndpoint<_iodp2z1e.ParaliOrder>(
        'orders',
        'requestOrder',
        {
          'buyerId': buyerId,
          'buyerName': buyerName,
          'listingId': listingId,
          'quantityKg': quantityKg,
        },
      );

  _ida.Future<_iodp2z1e.ParaliOrder> changeOrder({
    required int userId,
    required String userRole,
    required int orderId,
    required String action,
    int? carrierId,
  }) =>
      caller.callServerEndpoint<_iodp2z1e.ParaliOrder>(
        'orders',
        'changeOrder',
        {
          'userId': userId,
          'userRole': userRole,
          'orderId': orderId,
          'action': action,
          'carrierId': carrierId,
        },
      );
}

/// {@category Endpoint}
class EndpointPickupRoom extends _isc.EndpointRef {
  EndpointPickupRoom(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pickupRoom';

  _ida.Future<_in7cqc6m.PickupRoomView> getPickupRoom(
    int userId,
    String userRole,
    int orderId,
  ) =>
      caller.callServerEndpoint<_in7cqc6m.PickupRoomView>(
        'pickupRoom',
        'getPickupRoom',
        {
          'userId': userId,
          'userRole': userRole,
          'orderId': orderId,
        },
      );

  _ida.Future<_in7cqc6m.PickupRoomView> arrive(
    int userId,
    String userRole,
    int orderId,
  ) =>
      caller.callServerEndpoint<_in7cqc6m.PickupRoomView>(
        'pickupRoom',
        'arrive',
        {
          'userId': userId,
          'userRole': userRole,
          'orderId': orderId,
        },
      );
}

class Modules {
  Modules(Client client) {
    auth = _i312scxx.Caller(client);
  }

  late final _i312scxx.Caller auth;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
          host,
          _il2as5qe.Protocol(),
          securityContext: securityContext,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
          httpClientOverride: httpClientOverride,
        ) {
    auth = EndpointAuth(this);
    insights = EndpointInsights(this);
    listings = EndpointListings(this);
    orders = EndpointOrders(this);
    pickupRoom = EndpointPickupRoom(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointInsights insights;

  late final EndpointListings listings;

  late final EndpointOrders orders;

  late final EndpointPickupRoom pickupRoom;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'insights': insights,
        'listings': listings,
        'orders': orders,
        'pickupRoom': pickupRoom,
      };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

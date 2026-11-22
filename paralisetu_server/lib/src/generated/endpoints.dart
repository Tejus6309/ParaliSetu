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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import '../endpoints/auth_endpoint.dart' as _iyggisn2;
import '../endpoints/insights_endpoint.dart' as _iuy2wz0g;
import '../endpoints/listings_endpoint.dart' as _is42bjh6;
import '../endpoints/orders_endpoint.dart' as _ircrt8gp;
import '../endpoints/pickup_room_endpoint.dart' as _ie01veol;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    initializeOwnEndpoints(server);
    modules['serverpod_auth'] = _i1n3uhu0.Endpoints()
      ..initializeOwnEndpoints(server);
  }

  @override
  void initializeOwnEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'auth': _iyggisn2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'insights': _iuy2wz0g.InsightsEndpoint()
        ..initialize(
          server,
          'insights',
          null,
        ),
      'listings': _is42bjh6.ListingsEndpoint()
        ..initialize(
          server,
          'listings',
          null,
        ),
      'orders': _ircrt8gp.OrdersEndpoint()
        ..initialize(
          server,
          'orders',
          null,
        ),
      'pickupRoom': _ie01veol.PickupRoomEndpoint()
        ..initialize(
          server,
          'pickupRoom',
          null,
        ),
    };
    connectors['auth'] = _is.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _iyggisn2.AuthEndpoint).login(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _iyggisn2.AuthEndpoint).register(
            session,
            params['name'],
            params['email'],
            params['password'],
            params['role'],
          ),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _iyggisn2.AuthEndpoint).me(
            session,
            params['userId'],
          ),
        ),
      },
    );
    connectors['insights'] = _is.EndpointConnector(
      name: 'insights',
      endpoint: endpoints['insights']!,
      methodConnectors: {
        'matches': _is.MethodConnector(
          name: 'matches',
          params: {
            'crop': _is.ParameterDescription(
              name: 'crop',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'district': _is.ParameterDescription(
              name: 'district',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'quantityKg': _is.ParameterDescription(
              name: 'quantityKg',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'maxPrice': _is.ParameterDescription(
              name: 'maxPrice',
              type: _is.getType<double?>(),
              nullable: true,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['insights'] as _iuy2wz0g.InsightsEndpoint).matches(
            session,
            crop: params['crop'],
            district: params['district'],
            quantityKg: params['quantityKg'],
            maxPrice: params['maxPrice'],
          ),
        ),
        'impact': _is.MethodConnector(
          name: 'impact',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['insights'] as _iuy2wz0g.InsightsEndpoint)
                  .impact(session),
        ),
      },
    );
    connectors['listings'] = _is.EndpointConnector(
      name: 'listings',
      endpoint: endpoints['listings']!,
      methodConnectors: {
        'browse': _is.MethodConnector(
          name: 'browse',
          params: {
            'q': _is.ParameterDescription(
              name: 'q',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'crop': _is.ParameterDescription(
              name: 'crop',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'district': _is.ParameterDescription(
              name: 'district',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'minKg': _is.ParameterDescription(
              name: 'minKg',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'harvestAfter': _is.ParameterDescription(
              name: 'harvestAfter',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).browse(
            session,
            q: params['q'],
            crop: params['crop'],
            district: params['district'],
            minKg: params['minKg'],
            offset: params['offset'],
            harvestAfter: params['harvestAfter'],
          ),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'viewerUserId': _is.ParameterDescription(
              name: 'viewerUserId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'viewerRole': _is.ParameterDescription(
              name: 'viewerRole',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).detail(
            session,
            params['id'],
            viewerUserId: params['viewerUserId'],
            viewerRole: params['viewerRole'],
          ),
        ),
        'farmerListings': _is.MethodConnector(
          name: 'farmerListings',
          params: {
            'farmerId': _is.ParameterDescription(
              name: 'farmerId',
              type: _is.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint)
                  .farmerListings(
            session,
            params['farmerId'],
          ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'farmerId': _is.ParameterDescription(
              name: 'farmerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'farmerName': _is.ParameterDescription(
              name: 'farmerName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'crop': _is.ParameterDescription(
              name: 'crop',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'district': _is.ParameterDescription(
              name: 'district',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'availableKg': _is.ParameterDescription(
              name: 'availableKg',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pricePerKg': _is.ParameterDescription(
              name: 'pricePerKg',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'harvestDate': _is.ParameterDescription(
              name: 'harvestDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'availableFrom': _is.ParameterDescription(
              name: 'availableFrom',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'availableUntil': _is.ParameterDescription(
              name: 'availableUntil',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).create(
            session,
            farmerId: params['farmerId'],
            farmerName: params['farmerName'],
            crop: params['crop'],
            district: params['district'],
            description: params['description'],
            availableKg: params['availableKg'],
            pricePerKg: params['pricePerKg'],
            harvestDate: params['harvestDate'],
            availableFrom: params['availableFrom'],
            availableUntil: params['availableUntil'],
          ),
        ),
        'edit': _is.MethodConnector(
          name: 'edit',
          params: {
            'farmerId': _is.ParameterDescription(
              name: 'farmerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'crop': _is.ParameterDescription(
              name: 'crop',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'district': _is.ParameterDescription(
              name: 'district',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'availableKg': _is.ParameterDescription(
              name: 'availableKg',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pricePerKg': _is.ParameterDescription(
              name: 'pricePerKg',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'harvestDate': _is.ParameterDescription(
              name: 'harvestDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'availableFrom': _is.ParameterDescription(
              name: 'availableFrom',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'availableUntil': _is.ParameterDescription(
              name: 'availableUntil',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).edit(
            session,
            farmerId: params['farmerId'],
            id: params['id'],
            version: params['version'],
            crop: params['crop'],
            district: params['district'],
            description: params['description'],
            availableKg: params['availableKg'],
            pricePerKg: params['pricePerKg'],
            harvestDate: params['harvestDate'],
            availableFrom: params['availableFrom'],
            availableUntil: params['availableUntil'],
          ),
        ),
        'status': _is.MethodConnector(
          name: 'status',
          params: {
            'farmerId': _is.ParameterDescription(
              name: 'farmerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newStatus': _is.ParameterDescription(
              name: 'newStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).status(
            session,
            params['farmerId'],
            params['id'],
            params['newStatus'],
          ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'farmerId': _is.ParameterDescription(
              name: 'farmerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).delete(
            session,
            params['farmerId'],
            params['id'],
          ),
        ),
        'adminListings': _is.MethodConnector(
          name: 'adminListings',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint)
                  .adminListings(session),
        ),
        'moderate': _is.MethodConnector(
          name: 'moderate',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newStatus': _is.ParameterDescription(
              name: 'newStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listings'] as _is42bjh6.ListingsEndpoint).moderate(
            session,
            params['id'],
            params['newStatus'],
          ),
        ),
      },
    );
    connectors['orders'] = _is.EndpointConnector(
      name: 'orders',
      endpoint: endpoints['orders']!,
      methodConnectors: {
        'getOrders': _is.MethodConnector(
          name: 'getOrders',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userRole': _is.ParameterDescription(
              name: 'userRole',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['orders'] as _ircrt8gp.OrdersEndpoint).getOrders(
            session,
            params['userId'],
            params['userRole'],
          ),
        ),
        'getCarriers': _is.MethodConnector(
          name: 'getCarriers',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['orders'] as _ircrt8gp.OrdersEndpoint)
                  .getCarriers(session),
        ),
        'requestOrder': _is.MethodConnector(
          name: 'requestOrder',
          params: {
            'buyerId': _is.ParameterDescription(
              name: 'buyerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'buyerName': _is.ParameterDescription(
              name: 'buyerName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'quantityKg': _is.ParameterDescription(
              name: 'quantityKg',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['orders'] as _ircrt8gp.OrdersEndpoint).requestOrder(
            session,
            buyerId: params['buyerId'],
            buyerName: params['buyerName'],
            listingId: params['listingId'],
            quantityKg: params['quantityKg'],
          ),
        ),
        'changeOrder': _is.MethodConnector(
          name: 'changeOrder',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userRole': _is.ParameterDescription(
              name: 'userRole',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'action': _is.ParameterDescription(
              name: 'action',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'carrierId': _is.ParameterDescription(
              name: 'carrierId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['orders'] as _ircrt8gp.OrdersEndpoint).changeOrder(
            session,
            userId: params['userId'],
            userRole: params['userRole'],
            orderId: params['orderId'],
            action: params['action'],
            carrierId: params['carrierId'],
          ),
        ),
      },
    );
    connectors['pickupRoom'] = _is.EndpointConnector(
      name: 'pickupRoom',
      endpoint: endpoints['pickupRoom']!,
      methodConnectors: {
        'getPickupRoom': _is.MethodConnector(
          name: 'getPickupRoom',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userRole': _is.ParameterDescription(
              name: 'userRole',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pickupRoom'] as _ie01veol.PickupRoomEndpoint)
                  .getPickupRoom(
            session,
            params['userId'],
            params['userRole'],
            params['orderId'],
          ),
        ),
        'arrive': _is.MethodConnector(
          name: 'arrive',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userRole': _is.ParameterDescription(
              name: 'userRole',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pickupRoom'] as _ie01veol.PickupRoomEndpoint).arrive(
            session,
            params['userId'],
            params['userRole'],
            params['orderId'],
          ),
        ),
      },
    );
  }
}

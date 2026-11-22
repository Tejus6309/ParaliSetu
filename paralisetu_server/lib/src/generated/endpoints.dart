import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/auth_endpoint.dart' as _i2;
import '../endpoints/listings_endpoint.dart' as _i3;
import '../endpoints/orders_endpoint.dart' as _i4;
import '../endpoints/pickup_room_endpoint.dart' as _i5;
import '../endpoints/insights_endpoint.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'listings': _i3.ListingsEndpoint()
        ..initialize(
          server,
          'listings',
          null,
        ),
      'orders': _i4.OrdersEndpoint()
        ..initialize(
          server,
          'orders',
          null,
        ),
      'pickupRoom': _i5.PickupRoomEndpoint()
        ..initialize(
          server,
          'pickupRoom',
          null,
        ),
      'insights': _i6.InsightsEndpoint()
        ..initialize(
          server,
          'insights',
          null,
        ),
    };

    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(name: 'email', type: _i1.getType<String>(), nullable: false),
            'password': _i1.ParameterDescription(name: 'password', type: _i1.getType<String>(), nullable: false),
          },
          call: (session, params) => (endpoints['auth'] as _i2.AuthEndpoint).login(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'name': _i1.ParameterDescription(name: 'name', type: _i1.getType<String>(), nullable: false),
            'email': _i1.ParameterDescription(name: 'email', type: _i1.getType<String>(), nullable: false),
            'password': _i1.ParameterDescription(name: 'password', type: _i1.getType<String>(), nullable: false),
            'role': _i1.ParameterDescription(name: 'role', type: _i1.getType<String>(), nullable: false),
          },
          call: (session, params) => (endpoints['auth'] as _i2.AuthEndpoint).register(
            session,
            params['name'],
            params['email'],
            params['password'],
            params['role'],
          ),
        ),
        'me': _i1.MethodConnector(
          name: 'me',
          params: {
            'userId': _i1.ParameterDescription(name: 'userId', type: _i1.getType<int>(), nullable: false),
          },
          call: (session, params) => (endpoints['auth'] as _i2.AuthEndpoint).me(
            session,
            params['userId'],
          ),
        ),
      },
    );

    connectors['listings'] = _i1.EndpointConnector(
      name: 'listings',
      endpoint: endpoints['listings']!,
      methodConnectors: {
        'browse': _i1.MethodConnector(
          name: 'browse',
          params: {
            'q': _i1.ParameterDescription(name: 'q', type: _i1.getType<String?>(), nullable: true),
            'crop': _i1.ParameterDescription(name: 'crop', type: _i1.getType<String?>(), nullable: true),
            'district': _i1.ParameterDescription(name: 'district', type: _i1.getType<String?>(), nullable: true),
            'minKg': _i1.ParameterDescription(name: 'minKg', type: _i1.getType<int>(), nullable: false),
            'offset': _i1.ParameterDescription(name: 'offset', type: _i1.getType<int>(), nullable: false),
            'harvestAfter': _i1.ParameterDescription(name: 'harvestAfter', type: _i1.getType<DateTime?>(), nullable: true),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).browse(
            session,
            q: params['q'],
            crop: params['crop'],
            district: params['district'],
            minKg: params['minKg'],
            offset: params['offset'],
            harvestAfter: params['harvestAfter'],
          ),
        ),
        'detail': _i1.MethodConnector(
          name: 'detail',
          params: {
            'id': _i1.ParameterDescription(name: 'id', type: _i1.getType<int>(), nullable: false),
            'viewerUserId': _i1.ParameterDescription(name: 'viewerUserId', type: _i1.getType<int?>(), nullable: true),
            'viewerRole': _i1.ParameterDescription(name: 'viewerRole', type: _i1.getType<String?>(), nullable: true),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).detail(
            session,
            params['id'],
            viewerUserId: params['viewerUserId'],
            viewerRole: params['viewerRole'],
          ),
        ),
        'farmerListings': _i1.MethodConnector(
          name: 'farmerListings',
          params: {
            'farmerId': _i1.ParameterDescription(name: 'farmerId', type: _i1.getType<int>(), nullable: false),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).farmerListings(
            session,
            params['farmerId'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'farmerId': _i1.ParameterDescription(name: 'farmerId', type: _i1.getType<int>(), nullable: false),
            'farmerName': _i1.ParameterDescription(name: 'farmerName', type: _i1.getType<String>(), nullable: false),
            'crop': _i1.ParameterDescription(name: 'crop', type: _i1.getType<String>(), nullable: false),
            'district': _i1.ParameterDescription(name: 'district', type: _i1.getType<String>(), nullable: false),
            'description': _i1.ParameterDescription(name: 'description', type: _i1.getType<String>(), nullable: false),
            'availableKg': _i1.ParameterDescription(name: 'availableKg', type: _i1.getType<int>(), nullable: false),
            'pricePerKg': _i1.ParameterDescription(name: 'pricePerKg', type: _i1.getType<double>(), nullable: false),
            'harvestDate': _i1.ParameterDescription(name: 'harvestDate', type: _i1.getType<DateTime>(), nullable: false),
            'availableFrom': _i1.ParameterDescription(name: 'availableFrom', type: _i1.getType<DateTime>(), nullable: false),
            'availableUntil': _i1.ParameterDescription(name: 'availableUntil', type: _i1.getType<DateTime>(), nullable: false),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).create(
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
        'edit': _i1.MethodConnector(
          name: 'edit',
          params: {
            'farmerId': _i1.ParameterDescription(name: 'farmerId', type: _i1.getType<int>(), nullable: false),
            'id': _i1.ParameterDescription(name: 'id', type: _i1.getType<int>(), nullable: false),
            'version': _i1.ParameterDescription(name: 'version', type: _i1.getType<int>(), nullable: false),
            'crop': _i1.ParameterDescription(name: 'crop', type: _i1.getType<String>(), nullable: false),
            'district': _i1.ParameterDescription(name: 'district', type: _i1.getType<String>(), nullable: false),
            'description': _i1.ParameterDescription(name: 'description', type: _i1.getType<String>(), nullable: false),
            'availableKg': _i1.ParameterDescription(name: 'availableKg', type: _i1.getType<int>(), nullable: false),
            'pricePerKg': _i1.ParameterDescription(name: 'pricePerKg', type: _i1.getType<double>(), nullable: false),
            'harvestDate': _i1.ParameterDescription(name: 'harvestDate', type: _i1.getType<DateTime>(), nullable: false),
            'availableFrom': _i1.ParameterDescription(name: 'availableFrom', type: _i1.getType<DateTime>(), nullable: false),
            'availableUntil': _i1.ParameterDescription(name: 'availableUntil', type: _i1.getType<DateTime>(), nullable: false),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).edit(
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
        'status': _i1.MethodConnector(
          name: 'status',
          params: {
            'farmerId': _i1.ParameterDescription(name: 'farmerId', type: _i1.getType<int>(), nullable: false),
            'id': _i1.ParameterDescription(name: 'id', type: _i1.getType<int>(), nullable: false),
            'newStatus': _i1.ParameterDescription(name: 'newStatus', type: _i1.getType<String>(), nullable: false),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).status(
            session,
            params['farmerId'],
            params['id'],
            params['newStatus'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'farmerId': _i1.ParameterDescription(name: 'farmerId', type: _i1.getType<int>(), nullable: false),
            'id': _i1.ParameterDescription(name: 'id', type: _i1.getType<int>(), nullable: false),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).delete(
            session,
            params['farmerId'],
            params['id'],
          ),
        ),
        'adminListings': _i1.MethodConnector(
          name: 'adminListings',
          params: {},
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).adminListings(session),
        ),
        'moderate': _i1.MethodConnector(
          name: 'moderate',
          params: {
            'id': _i1.ParameterDescription(name: 'id', type: _i1.getType<int>(), nullable: false),
            'newStatus': _i1.ParameterDescription(name: 'newStatus', type: _i1.getType<String>(), nullable: false),
          },
          call: (session, params) => (endpoints['listings'] as _i3.ListingsEndpoint).moderate(
            session,
            params['id'],
            params['newStatus'],
          ),
        ),
      },
    );

    connectors['orders'] = _i1.EndpointConnector(
      name: 'orders',
      endpoint: endpoints['orders']!,
      methodConnectors: {
        'getOrders': _i1.MethodConnector(
          name: 'getOrders',
          params: {
            'userId': _i1.ParameterDescription(name: 'userId', type: _i1.getType<int>(), nullable: false),
            'userRole': _i1.ParameterDescription(name: 'userRole', type: _i1.getType<String>(), nullable: false),
          },
          call: (session, params) => (endpoints['orders'] as _i4.OrdersEndpoint).getOrders(
            session,
            params['userId'],
            params['userRole'],
          ),
        ),
        'getCarriers': _i1.MethodConnector(
          name: 'getCarriers',
          params: {},
          call: (session, params) => (endpoints['orders'] as _i4.OrdersEndpoint).getCarriers(session),
        ),
        'requestOrder': _i1.MethodConnector(
          name: 'requestOrder',
          params: {
            'buyerId': _i1.ParameterDescription(name: 'buyerId', type: _i1.getType<int>(), nullable: false),
            'buyerName': _i1.ParameterDescription(name: 'buyerName', type: _i1.getType<String>(), nullable: false),
            'listingId': _i1.ParameterDescription(name: 'listingId', type: _i1.getType<int>(), nullable: false),
            'quantityKg': _i1.ParameterDescription(name: 'quantityKg', type: _i1.getType<int>(), nullable: false),
          },
          call: (session, params) => (endpoints['orders'] as _i4.OrdersEndpoint).requestOrder(
            session,
            buyerId: params['buyerId'],
            buyerName: params['buyerName'],
            listingId: params['listingId'],
            quantityKg: params['quantityKg'],
          ),
        ),
        'changeOrder': _i1.MethodConnector(
          name: 'changeOrder',
          params: {
            'userId': _i1.ParameterDescription(name: 'userId', type: _i1.getType<int>(), nullable: false),
            'userRole': _i1.ParameterDescription(name: 'userRole', type: _i1.getType<String>(), nullable: false),
            'orderId': _i1.ParameterDescription(name: 'orderId', type: _i1.getType<int>(), nullable: false),
            'action': _i1.ParameterDescription(name: 'action', type: _i1.getType<String>(), nullable: false),
            'carrierId': _i1.ParameterDescription(name: 'carrierId', type: _i1.getType<int?>(), nullable: true),
          },
          call: (session, params) => (endpoints['orders'] as _i4.OrdersEndpoint).changeOrder(
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

    connectors['pickupRoom'] = _i1.EndpointConnector(
      name: 'pickupRoom',
      endpoint: endpoints['pickupRoom']!,
      methodConnectors: {
        'getPickupRoom': _i1.MethodConnector(
          name: 'getPickupRoom',
          params: {
            'userId': _i1.ParameterDescription(name: 'userId', type: _i1.getType<int>(), nullable: false),
            'userRole': _i1.ParameterDescription(name: 'userRole', type: _i1.getType<String>(), nullable: false),
            'orderId': _i1.ParameterDescription(name: 'orderId', type: _i1.getType<int>(), nullable: false),
          },
          call: (session, params) => (endpoints['pickupRoom'] as _i5.PickupRoomEndpoint).getPickupRoom(
            session,
            params['userId'],
            params['userRole'],
            params['orderId'],
          ),
        ),
        'arrive': _i1.MethodConnector(
          name: 'arrive',
          params: {
            'userId': _i1.ParameterDescription(name: 'userId', type: _i1.getType<int>(), nullable: false),
            'userRole': _i1.ParameterDescription(name: 'userRole', type: _i1.getType<String>(), nullable: false),
            'orderId': _i1.ParameterDescription(name: 'orderId', type: _i1.getType<int>(), nullable: false),
          },
          call: (session, params) => (endpoints['pickupRoom'] as _i5.PickupRoomEndpoint).arrive(
            session,
            params['userId'],
            params['userRole'],
            params['orderId'],
          ),
        ),
      },
    );

    connectors['insights'] = _i1.EndpointConnector(
      name: 'insights',
      endpoint: endpoints['insights']!,
      methodConnectors: {
        'matches': _i1.MethodConnector(
          name: 'matches',
          params: {
            'crop': _i1.ParameterDescription(name: 'crop', type: _i1.getType<String>(), nullable: false),
            'district': _i1.ParameterDescription(name: 'district', type: _i1.getType<String>(), nullable: false),
            'quantityKg': _i1.ParameterDescription(name: 'quantityKg', type: _i1.getType<int>(), nullable: false),
            'maxPrice': _i1.ParameterDescription(name: 'maxPrice', type: _i1.getType<double?>(), nullable: true),
          },
          call: (session, params) => (endpoints['insights'] as _i6.InsightsEndpoint).matches(
            session,
            crop: params['crop'],
            district: params['district'],
            quantityKg: params['quantityKg'],
            maxPrice: params['maxPrice'],
          ),
        ),
        'impact': _i1.MethodConnector(
          name: 'impact',
          params: {},
          call: (session, params) => (endpoints['insights'] as _i6.InsightsEndpoint).impact(session),
        ),
      },
    );
  }
}

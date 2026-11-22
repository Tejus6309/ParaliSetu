import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'user.dart' as _i2;
import 'listing.dart' as _i3;
import 'order.dart' as _i4;
import 'match_result.dart' as _i5;
import 'impact_stats.dart' as _i6;
import 'pickup_room_view.dart' as _i7;

export 'user.dart';
export 'listing.dart';
export 'order.dart';
export 'match_result.dart';
export 'impact_stats.dart';
export 'pickup_room_view.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  static final Protocol instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.ParaliUser) {
      return _i2.ParaliUser.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i3.ParaliListing) {
      return _i3.ParaliListing.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i4.ParaliOrder) {
      return _i4.ParaliOrder.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i5.MatchResult) {
      return _i5.MatchResult.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i6.CropDelivery) {
      return _i6.CropDelivery.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i6.ImpactStats) {
      return _i6.ImpactStats.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i7.PickupRoomView) {
      return _i7.PickupRoomView.fromJson(data as Map<String, dynamic>) as T;
    }
    if (t == _i1.getType<List<_i3.ParaliListing>>()) {
      return (data as List).map((e) => deserialize<_i3.ParaliListing>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i4.ParaliOrder>>()) {
      return (data as List).map((e) => deserialize<_i4.ParaliOrder>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i5.MatchResult>>()) {
      return (data as List).map((e) => deserialize<_i5.MatchResult>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i6.CropDelivery>>()) {
      return (data as List).map((e) => deserialize<_i6.CropDelivery>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<_i2.ParaliUser>>()) {
      return (data as List).map((e) => deserialize<_i2.ParaliUser>(e)).toList() as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    if (data is _i2.ParaliUser) return 'ParaliUser';
    if (data is _i3.ParaliListing) return 'ParaliListing';
    if (data is _i4.ParaliOrder) return 'ParaliOrder';
    if (data is _i5.MatchResult) return 'MatchResult';
    if (data is _i6.CropDelivery) return 'CropDelivery';
    if (data is _i6.ImpactStats) return 'ImpactStats';
    if (data is _i7.PickupRoomView) return 'PickupRoomView';
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var className = data['className'];
    if (className is! String) {
      return super.deserializeByClassName(data);
    }
    if (className == 'ParaliUser') {
      return deserialize<_i2.ParaliUser>(data['data']);
    }
    if (className == 'ParaliListing') {
      return deserialize<_i3.ParaliListing>(data['data']);
    }
    if (className == 'ParaliOrder') {
      return deserialize<_i4.ParaliOrder>(data['data']);
    }
    if (className == 'MatchResult') {
      return deserialize<_i5.MatchResult>(data['data']);
    }
    if (className == 'CropDelivery') {
      return deserialize<_i6.CropDelivery>(data['data']);
    }
    if (className == 'ImpactStats') {
      return deserialize<_i6.ImpactStats>(data['data']);
    }
    if (className == 'PickupRoomView') {
      return deserialize<_i7.PickupRoomView>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:paralisetu_client/src/protocol/listing.dart' as _ire2x1fo;
import 'package:paralisetu_client/src/protocol/match_result.dart' as _ir2pm0go;
import 'package:paralisetu_client/src/protocol/order.dart' as _iodp2z1e;
import 'package:paralisetu_client/src/protocol/user.dart' as _i1jvt56g;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i312scxx;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'crop_delivery.dart' as _ir0dk6yr;
import 'impact_stats.dart' as _imo0i0bf;
import 'listing.dart' as _ir9e9w84;
import 'match_result.dart' as _iai9feud;
import 'order.dart' as _ir1ryoer;
import 'pickup_room_view.dart' as _iadmxuya;
import 'user.dart' as _iv73i78m;
export 'crop_delivery.dart';
export 'impact_stats.dart';
export 'listing.dart';
export 'match_result.dart';
export 'order.dart';
export 'pickup_room_view.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager
    implements _isc.ProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _isc.ProtocolDeserialization get deserializationMetadata =>
      _isc.ProtocolDeserialization.cached(
        this,
        types: const [
          _isc.getType<_ir0dk6yr.CropDelivery>,
          _isc.getType<_imo0i0bf.ImpactStats>,
          _isc.getType<_ir9e9w84.ParaliListing>,
          _isc.getType<_iai9feud.MatchResult>,
          _isc.getType<_ir1ryoer.ParaliOrder>,
          _isc.getType<_iadmxuya.PickupRoomView>,
          _isc.getType<_iv73i78m.ParaliUser>,
          _isc.getType<_ir0dk6yr.CropDelivery?>,
          _isc.getType<_imo0i0bf.ImpactStats?>,
          _isc.getType<_ir9e9w84.ParaliListing?>,
          _isc.getType<_iai9feud.MatchResult?>,
          _isc.getType<_ir1ryoer.ParaliOrder?>,
          _isc.getType<_iadmxuya.PickupRoomView?>,
          _isc.getType<_iv73i78m.ParaliUser?>,
          _isc.getType<List<_ir0dk6yr.CropDelivery>>,
          _isc.getType<List<String>>,
          _isc.getType<List<_ir2pm0go.MatchResult>>,
          _isc.getType<List<_ire2x1fo.ParaliListing>>,
          _isc.getType<List<_iodp2z1e.ParaliOrder>>,
          _isc.getType<List<_i1jvt56g.ParaliUser>>,
        ],
        modules: const [_i312scxx.Protocol.new],
        classNames: const [
          'CropDelivery',
          'ImpactStats',
          'ParaliListing',
          'MatchResult',
          'ParaliOrder',
          'PickupRoomView',
          'ParaliUser',
        ],
      );

  static String? getClassNameFromObjectJson(dynamic data) =>
      _isc.ProtocolDeserialization.readClassName(data);

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    final rawDataClassName = _isc.ProtocolDeserialization.readClassName(data);
    final dataClassName = rawDataClassName;
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ir0dk6yr.CropDelivery) {
      return _ir0dk6yr.CropDelivery.fromJson(data) as T;
    }
    if (t == _imo0i0bf.ImpactStats) {
      return _imo0i0bf.ImpactStats.fromJson(data) as T;
    }
    if (t == _ir9e9w84.ParaliListing) {
      return _ir9e9w84.ParaliListing.fromJson(data) as T;
    }
    if (t == _iai9feud.MatchResult) {
      return _iai9feud.MatchResult.fromJson(data) as T;
    }
    if (t == _ir1ryoer.ParaliOrder) {
      return _ir1ryoer.ParaliOrder.fromJson(data) as T;
    }
    if (t == _iadmxuya.PickupRoomView) {
      return _iadmxuya.PickupRoomView.fromJson(data) as T;
    }
    if (t == _iv73i78m.ParaliUser) {
      return _iv73i78m.ParaliUser.fromJson(data) as T;
    }
    if (t == _isc.getType<_ir0dk6yr.CropDelivery?>()) {
      return (data != null ? _ir0dk6yr.CropDelivery.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imo0i0bf.ImpactStats?>()) {
      return (data != null ? _imo0i0bf.ImpactStats.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ir9e9w84.ParaliListing?>()) {
      return (data != null ? _ir9e9w84.ParaliListing.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iai9feud.MatchResult?>()) {
      return (data != null ? _iai9feud.MatchResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ir1ryoer.ParaliOrder?>()) {
      return (data != null ? _ir1ryoer.ParaliOrder.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iadmxuya.PickupRoomView?>()) {
      return (data != null ? _iadmxuya.PickupRoomView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iv73i78m.ParaliUser?>()) {
      return (data != null ? _iv73i78m.ParaliUser.fromJson(data) : null) as T;
    }
    if (t == List<_ir0dk6yr.CropDelivery>) {
      return (data as List)
          .map((e) => deserialize<_ir0dk6yr.CropDelivery>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ir2pm0go.MatchResult>) {
      return (data as List)
          .map((e) => deserialize<_ir2pm0go.MatchResult>(e))
          .toList() as T;
    }
    if (t == List<_ire2x1fo.ParaliListing>) {
      return (data as List)
          .map((e) => deserialize<_ire2x1fo.ParaliListing>(e))
          .toList() as T;
    }
    if (t == List<_iodp2z1e.ParaliOrder>) {
      return (data as List)
          .map((e) => deserialize<_iodp2z1e.ParaliOrder>(e))
          .toList() as T;
    }
    if (t == List<_i1jvt56g.ParaliUser>) {
      return (data as List)
          .map((e) => deserialize<_i1jvt56g.ParaliUser>(e))
          .toList() as T;
    }
    final modules = deserializationMetadata.modulesForDeserialization(
      t,
      className: rawDataClassName,
    );
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _isc.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ir0dk6yr.CropDelivery => 'CropDelivery',
      _imo0i0bf.ImpactStats => 'ImpactStats',
      _ir9e9w84.ParaliListing => 'ParaliListing',
      _iai9feud.MatchResult => 'MatchResult',
      _ir1ryoer.ParaliOrder => 'ParaliOrder',
      _iadmxuya.PickupRoomView => 'PickupRoomView',
      _iv73i78m.ParaliUser => 'ParaliUser',
      _ => null
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('paralisetu.', '');
    }

    switch (data) {
      case _ir0dk6yr.CropDelivery():
        return 'CropDelivery';
      case _imo0i0bf.ImpactStats():
        return 'ImpactStats';
      case _ir9e9w84.ParaliListing():
        return 'ParaliListing';
      case _iai9feud.MatchResult():
        return 'MatchResult';
      case _ir1ryoer.ParaliOrder():
        return 'ParaliOrder';
      case _iadmxuya.PickupRoomView():
        return 'PickupRoomView';
      case _iv73i78m.ParaliUser():
        return 'ParaliUser';
    }
    className = _i312scxx.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CropDelivery') {
      return deserialize<_ir0dk6yr.CropDelivery>(data['data']);
    }
    if (dataClassName == 'ImpactStats') {
      return deserialize<_imo0i0bf.ImpactStats>(data['data']);
    }
    if (dataClassName == 'ParaliListing') {
      return deserialize<_ir9e9w84.ParaliListing>(data['data']);
    }
    if (dataClassName == 'MatchResult') {
      return deserialize<_iai9feud.MatchResult>(data['data']);
    }
    if (dataClassName == 'ParaliOrder') {
      return deserialize<_ir1ryoer.ParaliOrder>(data['data']);
    }
    if (dataClassName == 'PickupRoomView') {
      return deserialize<_iadmxuya.PickupRoomView>(data['data']);
    }
    if (dataClassName == 'ParaliUser') {
      return deserialize<_iv73i78m.ParaliUser>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      return _i312scxx.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(15),
      });
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i312scxx.Protocol().registerHostProtocol('paralisetu', this);
  }

  @override
  String getModuleName() => 'paralisetu';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i312scxx.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}

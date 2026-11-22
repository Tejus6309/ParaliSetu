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
import 'package:paralisetu_client/src/protocol/protocol.dart' as _ibpb3c0d;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'listing.dart' as _ir9e9w84;

abstract class MatchResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MatchResult._({
    required this.listing,
    required this.score,
    required this.reasons,
  });

  factory MatchResult({
    required _ir9e9w84.ParaliListing listing,
    required int score,
    required List<String> reasons,
  }) = _MatchResultImpl;

  factory MatchResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchResult(
      listing: _ibpb3c0d.Protocol()
          .deserialize<_ir9e9w84.ParaliListing>(jsonSerialization['listing']),
      score: jsonSerialization['score'] as int,
      reasons: _ibpb3c0d.Protocol()
          .deserialize<List<String>>(jsonSerialization['reasons']),
    );
  }

  _ir9e9w84.ParaliListing listing;

  int score;

  List<String> reasons;

  /// Returns a shallow copy of this [MatchResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MatchResult copyWith({
    _ir9e9w84.ParaliListing? listing,
    int? score,
    List<String>? reasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MatchResult',
      'listing': listing.toJson(),
      'score': score,
      'reasons': reasons.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MatchResult',
      'listing': listing.toJsonForProtocol(),
      'score': score,
      'reasons': reasons.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MatchResultImpl extends MatchResult {
  _MatchResultImpl({
    required _ir9e9w84.ParaliListing listing,
    required int score,
    required List<String> reasons,
  }) : super._(
          listing: listing,
          score: score,
          reasons: reasons,
        );

  /// Returns a shallow copy of this [MatchResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MatchResult copyWith({
    _ir9e9w84.ParaliListing? listing,
    int? score,
    List<String>? reasons,
  }) {
    return MatchResult(
      listing: listing ?? this.listing.copyWith(),
      score: score ?? this.score,
      reasons: reasons ?? this.reasons.map((e0) => e0).toList(),
    );
  }
}

import 'package:serverpod/serverpod.dart';
import 'listing.dart';

class MatchResult extends SerializableModel {
  ParaliListing listing;
  int score;
  List<String> reasons;

  MatchResult({
    required this.listing,
    required this.score,
    required this.reasons,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'listing': listing.toJson(),
      'score': score,
      'reasons': reasons,
    };
  }

  factory MatchResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchResult(
      listing: ParaliListing.fromJson(jsonSerialization['listing'] as Map<String, dynamic>),
      score: jsonSerialization['score'] as int,
      reasons: (jsonSerialization['reasons'] as List).map((e) => e as String).toList(),
    );
  }
}

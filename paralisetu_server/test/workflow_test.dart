import 'package:test/test.dart';
import 'package:paralisetu_server/src/endpoints/orders_endpoint.dart';
import 'package:paralisetu_server/src/endpoints/insights_endpoint.dart';
import 'package:paralisetu_server/src/generated/protocol.dart';

void main() {
  group('Workflow Tests for Serverpod Backend', () {
    test('acceptance reserves and cancellation restores until pickup', () {
      final accept = OrdersEndpoint.transition('FARMER', 'REQUESTED', 'ACCEPT');
      expect(accept.status, equals('ACCEPTED'));
      expect(accept.reserveSign, equals(1));

      final cancelBuyerAssigned = OrdersEndpoint.transition('BUYER', 'ASSIGNED', 'CANCEL');
      expect(cancelBuyerAssigned.status, equals('CANCELLED'));
      expect(cancelBuyerAssigned.reserveSign, equals(-1));

      final cancelBuyerRequested = OrdersEndpoint.transition('BUYER', 'REQUESTED', 'CANCEL');
      expect(cancelBuyerRequested.status, equals('CANCELLED'));
      expect(cancelBuyerRequested.reserveSign, equals(0));

      final deliver = OrdersEndpoint.transition('LOGISTICS', 'PICKED_UP', 'DELIVER');
      expect(deliver.status, equals('DELIVERED'));
      expect(deliver.reserveSign, equals(0));

      expect(
        () => OrdersEndpoint.transition('BUYER', 'PICKED_UP', 'CANCEL'),
        throwsException,
      );
      expect(
        () => OrdersEndpoint.transition('FARMER', 'ACCEPTED', 'ACCEPT'),
        throwsException,
      );
      expect(
        () => OrdersEndpoint.transition('ADMIN', 'PICKED_UP', 'DELIVER'),
        throwsException,
      );
    });

    test('scoring explains district and price preferences', () {
      final now = DateTime.now();
      final listing = ParaliListing(
        id: 1,
        farmerId: 10,
        crop: 'Rice straw',
        district: 'Ludhiana',
        description: 'Test residue',
        availableKg: 2000,
        pricePerKg: 2.40,
        harvestDate: now,
        availableFrom: now,
        availableUntil: now.add(const Duration(days: 30)),
        status: 'ACTIVE',
        version: 0,
      );

      final localMatch = InsightsEndpoint.rankListing(listing, ' ludhiana ', 2.40);
      expect(localMatch.score, equals(100));
      expect(localMatch.reasons, contains('Within budget (+10)'));
      expect(localMatch.reasons, contains('Preferred district (+15)'));

      final nonLocalMatch = InsightsEndpoint.rankListing(listing, 'Patiala', 2.39);
      expect(nonLocalMatch.score, equals(75));

      final noPriceCapMatch = InsightsEndpoint.rankListing(listing, 'Ludhiana', null);
      expect(noPriceCapMatch.score, equals(90));
    });
  });
}

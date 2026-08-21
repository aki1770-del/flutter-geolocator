import 'package:flutter_test/flutter_test.dart';
import 'package:geoclue/geoclue.dart';
import 'package:geolocator_linux/src/geoclue_x.dart';

/// GeoClue reports an unavailable value with a sentinel, and the `geoclue`
/// package already converts those sentinels to `null`
/// (`Altitude` → `-double.maxFinite`, `Heading`/`Speed` → `-1.0`).
///
/// These tests describe what should happen to that `null` when it reaches a
/// `Position`.
void main() {
  GeoClueLocation location({double? altitude, double? heading, double? speed}) {
    return GeoClueLocation(
      accuracy: 12.0,
      latitude: 52.0,
      longitude: 5.0,
      altitude: altitude,
      heading: heading,
      speed: speed,
      timestamp: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    );
  }

  group('a value GeoClue did not report', () {
    test('is not claimed as a measurement', () {
      final p = location().toPosition();

      expect(p.hasAltitude, isFalse);
      expect(p.hasHeading, isFalse);
      expect(p.hasSpeed, isFalse);
    });

    test('is distinguishable from the same value actually reported as 0.0', () {
      final absent = location().toPosition();
      final reported =
          location(altitude: 0.0, heading: 0.0, speed: 0.0).toPosition();

      expect(absent.hasHeading, isFalse);
      expect(reported.hasHeading, isTrue,
          reason: 'GeoClue reported a heading of 0.0 — due north — and that is '
              'a measurement');
      expect(absent, isNot(equals(reported)));
    });

    test(
        'the numeric values are unchanged, so existing consumers are unaffected',
        () {
      final p = location().toPosition();

      expect(p.altitude, 0.0);
      expect(p.heading, 0.0);
      expect(p.speed, 0.0);
    });
  });

  group('a value GeoClue has no field for at all', () {
    test('is never claimed as a measurement', () {
      final p =
          location(altitude: 100.0, heading: 90.0, speed: 5.0).toPosition();

      expect(p.hasAltitudeAccuracy, isFalse,
          reason: 'GeoClueLocation carries no vertical-accuracy field');
      expect(p.hasHeadingAccuracy, isFalse,
          reason: 'GeoClueLocation carries no heading-accuracy field');
      expect(p.hasSpeedAccuracy, isFalse,
          reason: 'GeoClueLocation carries no speed-accuracy field');
    });
  });

  group('accuracy', () {
    test('is always a measurement, because GeoClue requires it', () {
      final p = location().toPosition();

      expect(p.hasAccuracy, isTrue);
      expect(p.accuracy, 12.0);
    });
  });
}

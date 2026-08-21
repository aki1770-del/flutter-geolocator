import 'package:geoclue/geoclue.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

extension GeoClueLocationAccuracyStatus on GeoClueAccuracyLevel {
  LocationAccuracyStatus toStatus() {
    if (this == GeoClueAccuracyLevel.none) {
      return LocationAccuracyStatus.unknown;
    }
    if (this == GeoClueAccuracyLevel.exact) {
      return LocationAccuracyStatus.precise;
    }
    return LocationAccuracyStatus.reduced;
  }
}

extension GeoCluePosition on GeoClueLocation {
  Position toPosition() {
    return Position(
      // `accuracy` is required on `GeoClueLocation`, so it is always a
      // measurement.
      accuracy: accuracy,
      hasAccuracy: true,
      // GeoClue reports an unavailable value with a sentinel, and the
      // `geoclue` package already converts those to `null` (`Altitude` ->
      // `-double.maxFinite`, `Heading` and `Speed` -> `-1.0`). The `?? 0`
      // below keeps the reported value unchanged for existing consumers; the
      // flag records whether anything actually measured it.
      altitude: altitude ?? 0,
      hasAltitude: altitude != null,
      heading: heading ?? 0,
      hasHeading: heading != null,
      speed: speed ?? 0,
      hasSpeed: speed != null,
      // `GeoClueLocation` carries no vertical, heading or speed accuracy at
      // all, so there is nothing that could have measured these.
      altitudeAccuracy: 0,
      hasAltitudeAccuracy: false,
      headingAccuracy: 0,
      hasHeadingAccuracy: false,
      speedAccuracy: 0,
      hasSpeedAccuracy: false,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp ?? DateTime.now(),
    );
  }
}

extension GeoClueLocationAccuracy on LocationAccuracy {
  GeoClueAccuracyLevel toGeoClueAccuracyLevel() {
    switch (this) {
      case LocationAccuracy.reduced:
      case LocationAccuracy.lowest:
        return GeoClueAccuracyLevel.country;
      case LocationAccuracy.low:
        return GeoClueAccuracyLevel.city;
      case LocationAccuracy.medium:
        return GeoClueAccuracyLevel.neighborhood;
      case LocationAccuracy.high:
        return GeoClueAccuracyLevel.street;
      case LocationAccuracy.best:
      case LocationAccuracy.bestForNavigation:
        return GeoClueAccuracyLevel.exact;
    }
  }
}

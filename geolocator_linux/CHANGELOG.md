## 0.2.7

- Populates the `hasAccuracy`, `hasAltitude`, `hasHeading` and `hasSpeed` flags on `Position` from what GeoClue actually reported, and sets `hasAltitudeAccuracy`, `hasHeadingAccuracy` and `hasSpeedAccuracy` to `false` because `GeoClueLocation` carries no such fields. GeoClue signals an unavailable value with a sentinel and the `geoclue` package already converts those to `null`; that `null` was being replaced with `0`, so an unreported heading was indistinguishable from a measured course of due north. The reported numeric values are unchanged. Requires `geolocator_platform_interface: ^4.3.0`.

## 0.2.6

- Updates dependency on flutter_lints to version 6.0.0.

## 0.2.5

- Updates dependency on package_info_plus to version 10.0.0.

## 0.2.4

- Updates dependency on package_info_plus to version 9.0.0.

## 0.2.3

- Updates dependency on flutter_lints to version 5.0.0. Later added: of example project.

## 0.2.2

- Updates dart sdk to `sdk: ^3.5.0`
- Fixes analyzer issues

## 0.2.1

- Updates dependency on package_info_plus to version 8.0.0.

## 0.2.0+2

- Updates dependency on package_info_plus to version 5.0.1.

## 0.2.0+1

- Ensures the `Position` instance always contains a timestamp.

## 0.2.0

- Bumps `geolocator_platform_interface` dependency to `^4.1.0`.

## 0.1.3

- Improves GNOME detection.
- Adds the ability to open Location Settings in GNOME SHELL.

## 0.1.2

- Migrates to Dart SDK 2.15.0 and Flutter 2.8.0.

## 0.1.1

- Fixes repository URL of the package.

## 0.1.0

- Initial implementation for Linux.

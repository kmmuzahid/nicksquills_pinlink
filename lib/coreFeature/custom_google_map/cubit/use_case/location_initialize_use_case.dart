/*
 * @Author: Km Muzahid
 * @Date: 2026-03-07 14:50:47
 * @Email: km.muzahid@gmail.com
 */
import 'dart:convert';

import 'package:core_kit/utils/permission_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinlink/config/storage/storage.dart';

class LocationInitializationUseCase {
  const LocationInitializationUseCase(this.lastLocationKey);
  final String lastLocationKey;

  Future<bool> checkPermission() async {
    return await PermissionHelper.request(Permission.location);
  }

  Future<Position?> loadLastLocation() async {
    final jsonString = await Storage.instance.read(lastLocationKey);
    if (jsonString != null) {
      return Position.fromMap(json.decode(jsonString));
    }
    return null;
  }

  Future<Position?> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  /// Fast path: return last known position if recent (<= 1 minute), otherwise get fresh.
  /// Handles service/permission states and errors, returning null on failure.
  Future<Position?> getCurrentPositionFast() async {
    try {
      // Ensure service is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      // Ensure permission is granted
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // Try last known first
      final last = await Geolocator.getLastKnownPosition();
      if (last != null) {
        final age = DateTime.now().difference(last.timestamp);
        if (age <= const Duration(minutes: 1)) {
          return last;
        }
      }
      // Fallback to a fresh position
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  Future<void> savePosition(Position position) async {
    await Storage.instance.write(
      lastLocationKey,
      json.encode(position.toJson()),
    );
  }
}

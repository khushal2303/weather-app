class LocationPermissionException implements Exception {
  final String error;
  LocationPermissionException(this.error);
}

class LocationPermissionPermanentlyDeniedException implements Exception {
  final String error;
  LocationPermissionPermanentlyDeniedException(this.error);
}

class LocalStorageException implements Exception {
  const LocalStorageException([this.message]);

  final String? message;

  @override
  String toString() {
    return message != null
        ? 'LocalStorageException: $message'
        : 'LocalStorageException';
  }
}

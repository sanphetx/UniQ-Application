// Local or custom status code used inside the application only
final class ErrorCode {
  /// Unknown or unhandled error occurred
  static const int unidentified = 1000;

  /// Connection attempt timed out before establishing connection
  static const int connectionTimeout = 1001;

  /// Failed to establish connection to the server
  static const int connectionError = 1002;

  /// Timeout occurred while waiting for server response
  static const int receiveTimeout = 1003;

  /// Timeout occurred while sending request data to server
  static const int sendTimeout = 1004;

  /// Request was cancelled before completion
  static const int cancelled = 1005;

  /// Error occurred while accessing local storage data
  static const int localStorageError = 1006;

  /// No internet connection available
  static const int noInternetConnection = 1007;

  /// Failed to parse response data into expected format
  static const int dataParsingError = 1008;
}

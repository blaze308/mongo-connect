import 'package:mongo_dart/mongo_dart.dart';
import 'package:logging/logging.dart';

class MongoDBErrorHandler {
  // Create a logger for the class
  static final Logger _logger = Logger('MongoDBErrorHandler');

  /// Centralized method to handle MongoDB operations
  ///
  /// [operation]: A function that performs the database operation
  /// [errorMessage]: Custom error message to provide context
  /// [fallbackValue]: Optional default return value if operation fails
  static Future<T> handleMongoDBOperation<T>({
    required Future<T> Function() operation,
    required String errorMessage,
    T? fallbackValue,
    bool shouldThrow = false,
  }) async {
    try {
      // Execute the database operation
      return await operation();
    } on MongoDartError catch (mongoError) {
      // Specific handling for MongoDB-related errors
      _logger.severe('$errorMessage - MongoDB Error: ${mongoError.message}',
          mongoError, mongoError.stackTrace);

      // Optionally rethrow the error
      if (shouldThrow) rethrow;

      // Return fallback value if provided
      if (fallbackValue != null) return fallbackValue;

      // Default error handling based on return type
      if (T == List) return [] as T;
      if (T == Map) return {} as T;
      if (T == bool) return false as T;
      if (T == String) return '' as T;
      if (T == int) return 0 as T;

      // For other types, throw the error
      throw MongoDBOperationException(
        message: '$errorMessage - Operation failed',
        originalError: mongoError,
      );
    } catch (e) {
      // Catch-all for any other unexpected errors
      _logger.severe('$errorMessage - Unexpected Error: ${e.toString()}', e,
          StackTrace.current);

      // Optionally rethrow the error
      if (shouldThrow) rethrow;

      // Return fallback value if provided
      if (fallbackValue != null) return fallbackValue;

      // Throw a generic exception
      throw MongoDBOperationException(
        message: '$errorMessage - Unexpected error occurred',
        originalError: e,
      );
    }
  }
}

/// Custom exception for MongoDB operations
class MongoDBOperationException implements Exception {
  final String message;
  final dynamic originalError;

  MongoDBOperationException({
    required this.message,
    this.originalError,
  });

  @override
  String toString() {
    return 'MongoDBOperationException: $message\n'
        'Original Error: $originalError';
  }
}

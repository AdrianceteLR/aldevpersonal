import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) {
      _logError(provider, newValue.error, newValue.stackTrace);
    }
  }

  void _logError(ProviderBase provider, Object error, StackTrace? stackTrace) {
    if (kDebugMode) {
      print('Error in ${provider.name ?? provider.runtimeType}: $error');
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }
}
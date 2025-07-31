import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/core/utils/app_logger.dart';

/// Lưu tên tất cả các provider đang hoạt động
final Set<String> activeProviders = {};

/// Lưu giá trị hiện tại của mỗi provider
final Map<String, dynamic> providerValues = {};

class AppProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    final name = provider.name ?? provider.runtimeType.toString();
    activeProviders.add(name);
    providerValues[name] = value;
    AppLogger.info('🟢 ADDED → $name\nValue: $value');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final name = provider.name ?? provider.runtimeType.toString();
    providerValues[name] = newValue;
    AppLogger.info('🔄 UPDATED → $name\nOld: $previousValue\nNew: $newValue');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    final name = provider.name ?? provider.runtimeType.toString();
    activeProviders.remove(name);
    providerValues.remove(name);
    AppLogger.warning('❌ DISPOSED → $name');
  }
}

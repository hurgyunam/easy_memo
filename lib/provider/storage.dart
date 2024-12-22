import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final repositoryProvider = Provider<Storage>((ref) => Storage());

final controllerProvider = Provider<Storage>((ref) {
  return Storage();
});

class Storage {
  final secureStorage = const FlutterSecureStorage();

  void readMemosByDate() {}

  void readMemosByCategory() {}

  /**
   * TODO: ID로 UUID가짐. 이를 함수에서 반환
   */
  void writeMemo() {}
}

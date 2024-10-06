import 'package:e_commerce/core/logger/index.dart';
import 'package:e_commerce/core/provider/storage/index.dart';
import 'package:get_it/get_it.dart';

class Containers {
  Containers() {
    init();
  }

  void init() {
    final getIt = GetIt.instance;
    getIt.registerSingleton<BaseStorage>(BaseStorage());
  }

  Future<void> setup() async {
    try {
      var storageService = GetIt.I<BaseStorage>();
      await storageService.init();
    } catch (e) {
      Logger.error('----Initialize Error ---->  $e');
    }
  }
}

import 'dart:async';

import 'package:get/get.dart';

import '../../../brick/repository.dart';
import '../../logs/models/log.model.dart';

class HomeController extends GetxController {
  late final StreamSubscription<List<Log>> logsStreamSubscription;
  final logs = <Log>[].obs;
  var isLoading = true.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() async {
    try {
      isLoading.value = true;
      _updateLogs(await Repository().get<Log>());
      _listenFutureLogUpdates();
    } catch (error) {
      _showErrorMsg(error);
    } finally {
      super.onInit();
    }
  }

  @override
  void onClose() {
    logsStreamSubscription.cancel();
    super.onClose();
  }

  void _updateLogs(List<Log> data) {
    logs.value = data;
    isLoading.value = false;
  }

  void _listenFutureLogUpdates() {
    logsStreamSubscription = Repository()
        .subscribe<Log>()
        .listen(_updateLogs, onError: _showErrorMsg, cancelOnError: true);
  }

  void _showErrorMsg(Object error) {
    errorMsg.value = error.toString();
    isLoading.value = false;
  }
}

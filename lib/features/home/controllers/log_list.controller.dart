import 'dart:async';

import 'package:brick_core/core.dart';
import 'package:get/get.dart';

import '../../../brick/repository.dart';
import '../../logs/models/log.model.dart';

class LogListController extends GetxController {
  late final StreamSubscription<List<Log>> streamSubscription;
  final logs = <Log>[].obs;
  final query = Query(orderBy: [OrderBy.desc('date')]);
  var isLoading = true.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() async {
    try {
      isLoading.value = true;
      _updateLogs(await Repository().get<Log>(query: query));
      _listenFutureLogUpdates();
    } catch (error) {
      _showErrorMsg(error);
    } finally {
      super.onInit();
    }
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }

  void deleteLog(Log log) {
    Repository().delete(log);
  }

  void _updateLogs(List<Log> data) {
    data.sort((a, b) => b.date.compareTo(a.date));
    logs.value = data;
    isLoading.value = false;
  }

  void _listenFutureLogUpdates() {
    streamSubscription = Repository()
        .subscribe<Log>(query: query)
        .listen(_updateLogs, onError: _showErrorMsg, cancelOnError: true);
  }

  void _showErrorMsg(Object error) {
    errorMsg.value = error.toString();
    isLoading.value = false;
  }
}

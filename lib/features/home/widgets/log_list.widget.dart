import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../logs/models/log.model.dart';
import '../../logs/views/log.view.dart';
import '../controllers/log_list.controller.dart';
import 'subheading.widget.dart';

class LogList extends StatelessWidget {
  const LogList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogListController());
    return Obx(
      () => controller.logs.isEmpty
          ? Center(
              child: Text(
                controller.isLoading.value
                    ? 'Loading...'
                    : controller.errorMsg.isEmpty
                        ? 'No logs.'
                        : 'Error: ${controller.errorMsg.value}',
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Subheading('Logs'),
                ..._generateLogTiles(controller.logs),
              ],
            ),
    );
  }

  List<Widget> _generateLogTiles(List<Log> logs) {
    return List.generate(
      logs.length,
      (index) => _LogTile(log: logs[index]),
    );
  }
}

class _LogTile extends StatelessWidget {
  const _LogTile({required this.log});

  final Log log;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogListController>();
    return Slidable(
      key: ValueKey(log.id),
      endActionPane: ActionPane(
        motion: StretchMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => controller.deleteLog(log),
        ),
        children: [
          SlidableAction(
            onPressed: (context) => controller.deleteLog(log),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(DateFormat.yMMMMd().format(log.date)),
        onTap: () => Get.to(() => LogView(log: log)),
      ),
    );
  }
}

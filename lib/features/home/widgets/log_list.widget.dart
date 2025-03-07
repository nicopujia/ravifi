import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../logs/models/log.model.dart';
import '../../logs/views/log.view.dart';
import '../controllers/home.controller.dart';

class LogList extends StatelessWidget {
  const LogList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _generateLogTiles(controller.logs),
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
    final controller = Get.find<HomeController>();
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
        title: Text(DateFormat.yMMMMEEEEd().format(log.date)),
        onTap: () => Get.to(() => LogView(log: log)),
      ),
    );
  }
}

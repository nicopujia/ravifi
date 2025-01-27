import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../logs/models/log.model.dart';
import '../../logs/views/log.view.dart';
import '../controllers/home.controller.dart';

class LogTile extends StatelessWidget {
  const LogTile({super.key, required this.log});

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
        title: Text(DateFormat.yMMMMd().format(log.date)),
        onTap: () => Get.to(() => LogView(log: log)),
      ),
    );
  }
}

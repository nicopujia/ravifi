import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../logs/models/log.model.dart';

class LogTile extends StatelessWidget {
  const LogTile({super.key, required this.log});

  final Log log;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(DateFormat.yMMMMd().format(log.date)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ravifi/views/add_log_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(child: Placeholder()),
          Card(child: Placeholder()),
          Card(child: Placeholder()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddLogView()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

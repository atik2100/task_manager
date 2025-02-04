import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const TmAppBar(),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildTaskListView(),
              )
          ]
          ),
        ),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 10,
            itemBuilder: (context, index) {
                // return const TaskItemWidget();
            },
          );
  }

}


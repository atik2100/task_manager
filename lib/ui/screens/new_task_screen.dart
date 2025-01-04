import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/background.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_summary_counter_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const TmAppBar(),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildTaskListView(),
              )
          ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 10,
            itemBuilder: (context, index) {
                return const TaskItemWidget();
            },
          );
  }

  Widget _buildTaskSummaryByStatus() {
    return const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TaskStatusSummaryCounterWidget(
                    title: 'New',
                    count: '12',
                  ),
                  TaskStatusSummaryCounterWidget(
                    title: 'Progress',
                    count: '10',
                  ),
                  TaskStatusSummaryCounterWidget(
                    title: 'Completed',
                    count: '14',
                  ),
                  TaskStatusSummaryCounterWidget(
                    title: 'Cancelled',
                    count: '09',
                  ),
                ],
              ),
            ),
          );
  }
}


import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key, required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title:  Text(taskModel.title ?? ""),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(taskModel.description ?? ""),
            const SizedBox(height: 4),
             Text(taskModel.createdDate ?? ""),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue,
                  ),
                  child:  const Text("New",style: TextStyle(color: Colors.white),),
                ),

                Row(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.edit_note_sharp),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.pink,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.delete_forever_outlined),
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
